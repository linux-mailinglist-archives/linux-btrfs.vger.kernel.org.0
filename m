Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF63415C478
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgBMPri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:47:38 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:39400 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgBMPrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:36 -0500
Received: by mail-qk1-f175.google.com with SMTP id w15so6089011qkf.6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouGc9oRqgIZdoP9ZlkCx5G75cQp/gkQCmzTrRXV5DBA=;
        b=uH52LOwD3UDb3r2HfdIEIYVsgIKRQ36Raz1tE7MTj56uiX3h7lPUZBVpiOGOTJ7RxD
         D7/90u273x/sFDkPya6cnUMjYlnqyp+IlZeAl7DLlF/9k3JCC37KSjq4DvnlgSclr5Oe
         76n1VTeo2qv/dVxjt8KivpqNn/uLcv3epdhMnegF/y6F9Cu5EcVYMIl+nfqXd6sdZkHl
         8mNHtljqFy5kS2negs3pYwYgdc4job336Y1nk0hY/sbnluwg7pyAz2lq5ofU19VGHRhV
         r6TZm7tbtS18G93OJ5kg0Wv2qrNI6Mb0/WffGEbFHp+vphS5BtPOgWRtVcIKp/UvkvSo
         HFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouGc9oRqgIZdoP9ZlkCx5G75cQp/gkQCmzTrRXV5DBA=;
        b=qc8viaLXKPsW74WM5uwIfNbd8tJr7NubUjWIuEpuA93qR2l5ofN1fEBmhgGBsdUKt4
         R88ILTK5f2R8wpzy+j/K/4mn1EC/RQ8jJpgwroh+6ts0nwh1tS1EBAfLUrOtkUzObuRf
         KssAM0tCykXyLDlwlY+MTMwDOn86dTq0Sa/BA8TYXxRA7yVObEZPqFnwxJIv36Hkl6da
         DO4dhGeM8AypsRXGmuxD58OKB191Vpq5CPRUtidKVdV9bfLXC1e5kjqYORIe94xERcRX
         FKYge7zPsHVU1bxUAamS2uhuodJX+x5acxcLUhLjrBU79pMybLxlXIdMhxSl6zGCsBgg
         QUQg==
X-Gm-Message-State: APjAAAXSS2V73fyyXPbKMh6kGQbTzAli6advH1KsG5xL808OFB3V79ZI
        gfhgLe9NiHbwWgPETk990Zw3k3OUnmg=
X-Google-Smtp-Source: APXvYqw4nnWWB7lCnTqeLG0lvpEZ8Frg3XenKFnpauUTvAK4ERWEjKHtin/udznjpscdEJKCy4N1bw==
X-Received: by 2002:a37:554:: with SMTP id 81mr15826184qkf.297.1581608854783;
        Thu, 13 Feb 2020 07:47:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x4sm1484133qkx.33.2020.02.13.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4][v2] Error condition failure fixes
Date:   Thu, 13 Feb 2020 10:47:27 -0500
Message-Id: <20200213154731.90994-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Fixed the ins.objectid thing Nikolay pointed out, and reworked that patch a
  bit to do the right thing in case of a add_extent_mapping() further down in
  that function as well.

------------------- Original email -----------------------------
I've been running my bpf error injection stress script and been fixing what has
fallen out.  I don't think I've fixed everything yet, but to reduce the noise
from Dave's testing here's the current set of fixes I have.  These are based on
misc-next from late last week, but should apply cleanly to the recent set.
These aren't super important, but will cut down on the noise from things like
generic/019 and generic/475.  Thanks,

Josef


