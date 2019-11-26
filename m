Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2142F10975E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKZA4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 19:56:54 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45796 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 19:56:54 -0500
Received: by mail-pf1-f172.google.com with SMTP id z4so8265670pfn.12;
        Mon, 25 Nov 2019 16:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4cnOpUKO/ak7wZsq080KRZ4MzliYraExX52z03Tp4QM=;
        b=tjo40enAbZZJ9Z1cjzPcwDUKEQVyqnE1w/dqgCeYjDl6h8I56wd+br+RGrljaO0/TY
         Y6gSgS286AKqxJIqPIo+C5UIIsr8IDzdyHAwjN2+xpcPksuKn4ar6NHjl5udAAI0hl4r
         DQwIRuoxaf9XTeNepC4wl7Qxj1LXfPMZ+rp0hF/SFYNdXRnDdKdKSrHS9R1GHGUoGdSt
         2HMmPvE2hOc6EqKBZhluepCQ7i55Hz+s4+6jQ0pM5GXquF5mrtguevAw9P4WAMF9PB9A
         HjiJlKUrptuXuvkKHNI+1Wse740eA3NNrjkPcgphT4ZVIrEB85ZkxmeVfDxduotevxHo
         m+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4cnOpUKO/ak7wZsq080KRZ4MzliYraExX52z03Tp4QM=;
        b=f8WyXBcoUvP8i6DWINFwov33f1PRqRiaVVAHtTVwDNjex9rsq/jbwjDzowT3GyNy+L
         U2CL7oNVU2kqWWoLMZ7bOXxRwuh4zfsaKUUH5aJGpf+mpVzu/mYW6ZBGVocxNWpF9VII
         Cbq5UgjPPaFSq7jSz+Aa2PgA26ONfXjp090DXygjgaTj2Ut+yBw+o7hqV8X4lHJAV5I+
         e/KYZwoqzvcQ78RN4oObixUldbnjGD6xbQ6dSCLUO8F85VwXL/o+vDrIwe15VeqNzmRP
         Q01N8jWdPy0QZ+L/wayF9pbr8/9f5cnh7PmyG/GUbKqotaIPP1sXSmu9lYSTIB5UDFnN
         6N2g==
X-Gm-Message-State: APjAAAWs0UdeZY5cefBmYy9u7innjAEIFMK34BwL5DC78LrBxsuKlhiH
        YiPDXSPmzgw9fNJohYf2zUCTywX9
X-Google-Smtp-Source: APXvYqzQVwhggyvhv13YwDNBHVtRnXGuG8o8iTL6coevg4Lm+fbatbrkAjVYkwPvLUqSiy5md92CdA==
X-Received: by 2002:a63:da13:: with SMTP id c19mr34999229pgh.435.1574729811485;
        Mon, 25 Nov 2019 16:56:51 -0800 (PST)
Received: from hephaestus.prv.suse.net ([186.212.48.108])
        by smtp.gmail.com with ESMTPSA id w15sm9421223pfi.168.2019.11.25.16.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:56:50 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] btrfs qgroup cleanup
Date:   Mon, 25 Nov 2019 21:58:49 -0300
Message-Id: <20191126005851.11813-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

While reading the qgroup code and doing some tests, I found some two things
that I would like to change:
* Remove some useless code that was being set only to check if
  fs_info->quota_root was not NULL
* Check why creating a qgroup was returning EINVAL

The answer to the second point was: EINVAL is returned when a user tries to
create/delete/list/assign a qgroup to a subvolume, but this subvolume does
not have quota enabled. Talking with David, he suggested to change it to
ENOTCONN, following what is currently being used in balance and scrub.

So here are the changes. Please take a look!

Marcos Paulo de Souza (2):
  btrfs: qgroup: Cleanup quota_root checks
  btrfs: qgroup: Return -ENOTCONN instead of -EINVAL

 fs/btrfs/qgroup.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

-- 
2.23.0

