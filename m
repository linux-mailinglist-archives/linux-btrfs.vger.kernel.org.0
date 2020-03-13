Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7112A1850A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMVKB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:10:01 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:42433 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVKB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:10:01 -0400
Received: by mail-qv1-f48.google.com with SMTP id ca9so5424338qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDTsy9e6z/ID2US86vsjRI0JvqMzmiMnfCJTK6qiywY=;
        b=sImrsps1UxvKjpR/40rjRYW+UKmiR1UA0uuXbYNpM/wsx0jc1zxQXxxDbHh6X4hMCC
         NUwITCLWMZI4K4tVSc2VbT4cBdXjF95GN0tBgpxtTXlKgeNHWIwpOisysd8U1oh/IyW/
         WPeYfxiy4SYKeqEufa7b4YVoLmqK0/uHVpifbaooIOnv7DMsLjx7376KxharepwF0pEu
         53TUMtfNUGFi+fuO/4M2NMOIH7FLOSnVHr47QmIYfIla3Ph0eumRnDwWrSQdTqlHl1Np
         Mx61b81/w4ZjlqCS17Dtxf8GMgm4MSD6TQ5ieMTdSyJGtFoP9TkKznAjR0BSX2h/SKv9
         BFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDTsy9e6z/ID2US86vsjRI0JvqMzmiMnfCJTK6qiywY=;
        b=q+O2zdDE0weghA0KjsjSI/0mEd1p+qia4oJ1MkvNZoNCCP83y/MWNlTJcGnPRN40Mj
         BtThVL+1nVHkm/bmSv+7Huh+kSAkN9aIAjZaZkdsxv0LSjSQYVUUKux3HQaOBG9oBWWW
         Eg9cG7VD0bH4YyeQrcaEP3RcqpY8cD5UycuC+qQ5PaU0D2c8LY9nA53t6g7iMixXl14K
         QepPmuNlwTwaB1hps+e+WPxEIQVb2pNeq7IfzaaDwI3TMzG88Rpk8VLNTfJw4hL/TNGf
         T4dj6Kw3XsPEzJkOeYdUYZSGKWDc1vkWCJXwBadQx9a1YgwrfUhGmvUK7804C5bq0+nO
         TUkg==
X-Gm-Message-State: ANhLgQ2Aj8cAfBGm5IdEcO6mnFEK7HIFYHPlcwIkHXHMbTAtxeKAnjxb
        iUgs9U81vP89T/5/hsGWmluJA6GLBSwtSw==
X-Google-Smtp-Source: ADFU+vtZVc63P2WD8IwiVMxxMvENujacK9P4tdtLgAfEOsyjpjCWg4zCQ3WMNC7umtCh2DvsPhKnhQ==
X-Received: by 2002:a0c:c68a:: with SMTP id d10mr14563629qvj.126.1584133797535;
        Fri, 13 Mar 2020 14:09:57 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p191sm13733471qke.6.2020.03.13.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:09:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Drop some mis-uses of READA
Date:   Fri, 13 Mar 2020 17:09:52 -0400
Message-Id: <20200313210954.148686-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In debugging Zygo's huge commit delays I noticed we were burning a bunch of time
doing READA in cases where we don't need to.  The way READA works in btrfs is
we'll load up adjacent nodes and leaves as we walk down.  This is useful for
operations where we're going to be reading sequentially across the tree.

But for delayed refs we're looking up one bytenr, and then another one which
could be elsewhere in the tree.  With large enough extent trees this results in
a lot of unneeded latency.

The same applies to build_backref_tree, but that's even worse because we're
looking up backrefs, which are essentially randomly spread out across the extent
root.  Thanks,

Josef

