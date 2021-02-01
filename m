Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2852A30B21B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBAV3Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:25 -0500
Received: from smtp-36-i2.italiaonline.it ([213.209.12.36]:53173 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232419AbhBAV3N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:13 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkIlJHtRi3tS6gkIlGsyd; Mon, 01 Feb 2021 22:28:30 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214910; bh=O7yYYb/h5i4y9W+91katzMlol/N9lfq5yqjkUo8zeg4=;
        h=From;
        b=VOOozFKXYjaOF+k/Z5HxrRHLHQDqngBO79Vaa2XWB7jSXiQKXHL7v7h6zWO44LhhA
         qQqahB0uHy297kkhdBVbEvgUqXzMr3j9bz3dtLkROQrvLDl15PIe0kLoqaxpkLp4gI
         VyjjfD+Ch5reJPYP6r0dOlOL5sJQpcl1hBhXay3eJ1GIYKI0SbXea02Ro22uByDjW3
         8tGdZ5BAI7yRpEW5IOuIPHlC7q5ERhNU6gtt87RC2qOcSGDDm4bLAR+4PI+uaYKwaA
         sT2s4Myq1oc84UmM1W7y0nXlSIzm1L0D1ndvW4z8zKVKqS7Fg3HPjqpHd69H9h4zlm
         0EaJco9X8LMSw==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=6018727e cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=0rW4GLQXfm6wivBrp8oA:9 a=OFYGNbI0l5wA:10
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [RFC][PATCH V5] btrfs-progs: allocation_hint disk property
Date:   Mon,  1 Feb 2021 22:28:27 +0100
Message-Id: <20210201212829.64966-1-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCUsV6pvKkqL8AvR5O+eUJreb/b6xw+VF0BDZZ3/Kemnpxs0qxMgcKXpyhhOt+fZ87wb/eymhAz6TTldBFD49NfgWja+Cd3KQo1b7o10etnOryMNuEme
 uWDj05y01dkhHe+XkfWzxfudxzSJHOVTdXRfuar0QWnWzkXVlCfWrbcclLRf1MGmcD+ZERKGOfbmw6V7hejkBDs1oN0TwpsGslSHYBS3cB//zWdGRXJmk+nq
 LArF0iaFPC4vtp6J+3e5FfwcnmcJhmI+vWU2ppXm+SE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patches set is the userspace portion of the serie
"[PATCH V6] btrfs: allocation_hint mode".

Look this patches set for further information.

G.Baroncelli


--
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

