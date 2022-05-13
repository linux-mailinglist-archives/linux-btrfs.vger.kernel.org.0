Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EF5265F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381941AbiEMPXP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 13 May 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381922AbiEMPXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 11:23:14 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 08:23:11 PDT
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E463BC5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:23:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A11ED3F60E;
        Fri, 13 May 2022 17:14:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -0.011
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tK8zAPTX7z1G; Fri, 13 May 2022 17:14:21 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D54F63F36E;
        Fri, 13 May 2022 17:14:21 +0200 (CEST)
Received: from [192.168.0.126] (port=60920)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1npWzq-0002d9-2y; Fri, 13 May 2022 17:14:20 +0200
Date:   Fri, 13 May 2022 17:14:21 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <b49e00b.dcea448a.180bdfc2a51@tnonline.net>
In-Reply-To: <cover.1652428644.git.wqu@suse.com>
References: <cover.1652428644.git.wqu@suse.com>
Subject: Re: [PATCH 0/4] btrfs: cleanups and preparation for the incoming
 RAID56J features
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, 

---- From: Qu Wenruo <wqu@suse.com> -- Sent: 2022-05-13 - 10:34 ----

> Since I'm going to introduce two new chunk profiles, RAID5J and RAID6J
> (J for journal), 

Great to see work being done on the RAID56 parts of Btrfs. :) 

I am just a user of btrfs and don't have the full understanding of the internals, but it makes me a little curious that we choose to use journals and RMW instead of a CoW solution to solve the write hole. 


Since we need on-disk changes to implement it, could it not be better to rethink the raid56 modes and implement a solution with full CoW, such as variable stripe extents etc? It is likely much more work, but could have better performance because it avoids double writes and RMW cycles too. 

Thanks 
 
Forza

