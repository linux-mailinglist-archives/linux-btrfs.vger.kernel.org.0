Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41F5109035
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfKYOkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 09:40:16 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:38234 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:40:16 -0500
Received: by mail-qv1-f47.google.com with SMTP id q19so5782415qvs.5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8zoPpEH40Db3yBgiPqyTFEfxTskcvzX15cv3LRRtUs=;
        b=qdHAG5SUFPB1kdYxxeo8D/d7kglJtfAlhkrWlnFWM5PRdGvTGvTSLkOE9efQ59d8QC
         Fhz4t4yXF//MEWorv4rVYhn95iHSeYHU3oFoZ8n8lx/tpRtwGxyACLboXl2ZJBh/qUZM
         ViqrwY6zNU3VhqML9KqNSbQMLPa08u0sSvHP3c/goC7DzavLsWl7hsH/UVhDQEyLP+/8
         OtaklmcK7uihvC2zxoKHAPEbKG8n08yidxpVITKDnWC+UbT7YmnZwOummhW1i+az+2DR
         XtbwD80TzpBo2MrTbM6Byf5gKOJYDkoruZoSLjMoAyZAWBDPtBeLEgmQQh+/oGHaTpCv
         1QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8zoPpEH40Db3yBgiPqyTFEfxTskcvzX15cv3LRRtUs=;
        b=eW0Q/jCieltxvXu/gwydHMNDQZ81RB+oUdNdmh3Zp0RiWudortbo04+gJZ3w1gMfpZ
         kPuSsNXqfwU5jyj8uCGcFDm8RhfL1StH/T6Yfp3C7T1Mj4XULdUz7G2SIQusZbdIP1Lh
         GqqNQkXQHGwOVTEI9j3cAlxIDCeQzJpwTAuB6VnB3cimujhgIxJDkBg6RzltvUiGY2nX
         +0UvesOPrIeBpLO/gWdPolpg9r90fM2GvLyUbk3xqNoiGUsEV7nrzvXFhdmfvMIp80PK
         7FMYdhSgzTI9ohbzP169ElIOa8uDUbZJs31BuwK2sfEmXif5GIIBSedeO3ocHG3V/bSP
         3UkA==
X-Gm-Message-State: APjAAAXeJIok+Dcvllsvkj/kSOF4ii1omKjegdYgNKP9+sWLoarq2MW2
        9MIHNbYpMnDGfkp4QowjWLU/d537zXhraA==
X-Google-Smtp-Source: APXvYqza1uzhUBA7LnkGpY+YX8PAIJvUryT9ToNZdb7NOEAGPke2OAkADi0/D7M+ovFj86ruZOVMeQ==
X-Received: by 2002:a05:6214:12d2:: with SMTP id s18mr27817261qvv.199.1574692814190;
        Mon, 25 Nov 2019 06:40:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x68sm3460948qkc.22.2019.11.25.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:40:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 0/4][RFC] clean up how we mark block groups read only
Date:   Mon, 25 Nov 2019 09:40:07 -0500
Message-Id: <20191125144011.146722-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu has been looking into ENOSPC during relocation and noticed some weirdness
with inc_block_group_ro.  The problem is this code hasn't changed to keep up
with the rest of the reservation system.  It still assumes that the amount of
space used will always be less than the total space for the space info, which
hasn't been true for years since I introduced overcommitting.  This logic is
correct for DATA, but not for METADATA or SYSTEM.

The first few patches are just cleanups, and can probably be taken as is.  The
final patch is the real meat of the problem to address Qu's issues.  This is an
RFC because I'm elbow deep in another problem and haven't tested this beyond
compile testing, but I think it'll work.  Once I've gotten a chance to test it
and Qu has tested it I'll update the list if it's good to go as is, or send a V2
with any changes.  Thanks,

Josef

