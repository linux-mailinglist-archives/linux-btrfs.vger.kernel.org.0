Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D318119E489
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDKcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:48447 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgDDKcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Kg63jDxJE6Q7RKg65jI6WI; Sat, 04 Apr 2020 12:32:17 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585996337; bh=v5GXkAYXlRDB+G3QchwUz/DqODtZF0Pxm8NMl7Q+/uU=;
        h=From;
        b=TWIF6FhVGMQXgzXf2UgSBlkoEliTTdRcKoz6OL8mjmtn+J1Vey3LhScYgeRGZWqKo
         spyqndp1/hL3lfw95zhmyeg3xHL2CiJ2QHPv6gbc66ftsgnSosaIoljjmHzBu52K9b
         XDGEB6zrny10z9Fta5u1vJYPN3qFCAU6HI+lb2pgzwgRFhQ6wjRHih3PhEO9xxLVtD
         WsdlInyiUVwpWNCFBjNRSqfMPqhTCBotCZ1jLbX4EnsaR+rEuY2RuxeIismzQIhPtH
         GymsauiJDY5EMvnpe/Z0UQVRWiPe0IoNek8GXK6iao4tMlsUjcenXmH4Wwvcj4gyBF
         rUnqSlKWSrBmA==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=k2A2CUVQ5W2PnF00lrAA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/5] Add check for multiple profile in btrfs fi us
Date:   Sat,  4 Apr 2020 12:32:10 +0200
Message-Id: <20200404103212.40986-4-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200404103212.40986-1-kreijack@libero.it>
References: <20200404103212.40986-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKdd+esTeTN1C6k7X/myqPWbWe6+kX1Hj+B7yA5/cGAS/y098Pi5sAxP2Ivr+Mw8PWGotyjzcFi18TquKi0VV1LGpgwLI3p7KRWWBldwOSeChSby4yvj
 rs9lg2SBauptvJwvxaNBSJH6p1ZQqPdfoBycG5pG+LJBctlNXaTj0SLp5JJH2TPp55NKuMnFpN5CM/ktX88YiNjkSG7Sf9wpkUr+SUH47bRLQUeed7DLZ1EM
 A6ur/S/C7uAAz1PJm66H3J9JehzM7LaxHxCOV0tqb5U+G5TkUol4zKdz7+RHiCAYsECykkMhLbjcuGbypK1EdkRBvzDGsIQFaKP94DKbOjs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

A new line in the "Overall" section is added to inform that a 
'Multiple profile' is present.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/filesystem-usage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index aa7065d5..742b4ea4 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -492,6 +492,11 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	printf("    Global reserve:\t\t%*s\t(used: %s)\n", width,
 		pretty_size_mode(l_global_reserve, unit_mode),
 		pretty_size_mode(l_global_reserve_used, unit_mode));
+	if (btrfs_test_for_mixed_profiles_by_fd(fd) > 0)
+		printf("    Multiple profile:\t\t%*s\n", width, "YES");
+	else
+		printf("    Multiple profile:\t\t%*s\n", width, "no");
+
 
 exit:
 
-- 
2.26.0

