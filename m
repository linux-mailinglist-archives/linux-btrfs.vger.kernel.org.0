Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8555B629B91
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 15:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiKOOI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 09:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiKOOIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 09:08:54 -0500
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476F10541
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 06:08:50 -0800 (PST)
Received: from selket.spencercollyer.plus.com ([80.189.102.133])
        by smtp with ESMTP
        id uwcJoGacMAajauwcKoN4Tn; Tue, 15 Nov 2022 14:08:48
 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1668521328; bh=HkbYAobndFgRN/ZTf20tmQFE+l1iUcTL8Ie1az9ceIY=;
        h=Date:From:Cc:Subject:In-Reply-To:References;
        b=iwqBF/V8c/fTke/EwWrUiuDPIBCNKpjl62PrwAZyEpiVCPZnx3JxncGWrkqpgrg8T
         hhFA0w7STbzre2pDwwDoZYrs5WaYl8q87d6ug1g4ebvFUJTvVSoDevxtykNraQfuAR
         51mS06ybGR1AcLKNl5/REUIyJO7g0Hh8J4ssBk9e1UW31lIJv277fNIp6Vl5W9FZq1
         4B+DTF/JRthQpLnWF2r09JUsXdXY5uQv0+zbvdjnk8uWexnRxM3Ga03zkC2UmzIZOh
         Hc6KQ3ByheffMb70lxfAEy7zo1jjPfduGGvbBVl5fW7HFXhw+JJceGM7QYfKLi/2cW
         jo50MwEMJZJYw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=eI8AMVl1 c=1 sm=1 tr=0 ts=63739d70
 a=t3eprasJVEmiovQRZ0k/8A==:117 a=t3eprasJVEmiovQRZ0k/8A==:17
 a=9cW_t1CCXrUA:10 a=kj9zAlcOel0A:10 a=9xFQ1JgjjksA:10
 a=qXLSlRtegvdWgeqI6aIA:9 a=CjuIK1q_8ugA:10
Received: from selket (localhost.localdomain [127.0.0.1])
        by selket.spencercollyer.plus.com (Postfix) with ESMTP id 934EE80062
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 14:08:47 +0000 (GMT)
Date:   Tue, 15 Nov 2022 14:08:47 +0000
From:   Spencer Collyer <spencer@spencercollyer.plus.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Change BTRFS filesystem back to R/W from R/O
Message-ID: <20221115140847.12fa1902@selket>
In-Reply-To: <7be0584d-5596-189a-353a-63e4b21c3b5e@gmx.com>
References: <20221115122702.4ca83887@selket>
        <7be0584d-5596-189a-353a-63e4b21c3b5e@gmx.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPQjdvIcZe1wGDK/5dNkFak1TLS09BgSJJN00NfTIrXHulNI8sh4jwNZt6Vm10XIrtg6xbb9EguhbvKbZDxUaVUTAfdayZDy3l9DyEo87U5Y0XROBqPp
 H4MqCnqfs+5sQRNO8pHJLFPZ/AU+RBOUuNHqXcpfv5Pn7H2l7p0VVOPUjbadiG8Chp6PoQK0bAEKoMH2t7tLj2yuI9KrRvO6qcn3uVLWdZD0Rem5fsbdCdUL
 f0E3ohm0OWtlsnfgoRHC8A==
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,MISSING_HEADERS,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Resending to the list as I accidentally sent it just to Qu.)

On Tue, 15 Nov 2022 20:41:54 +0800, Qu Wenruo wrote:

> Considering you have some metadata space left, I believe you can free 
> enough space by deleting files (aka, moving it to other filesystems)
> 
> Thanks,
> Qu  

Hi Qu,

Thanks for that. You say I should move some files to other filesystems, but that's really the nub of my problem - the filesystem is marked as read-only. Am I Ok to do what I mentioned previously:

> 1) Unmount the filesystem.
> 2) Remount it as R/W
> 3) Move data to the external disk  

If that is all good, would I need to do anything else or would the BTRFS system sort itself out correctly?

Thanks for your attention,

Spencer

PS. The output form the 'btrfs fi usage /data' command you requested is as follows (run as root to get everything):

Overall:
    Device size:		  10.92TiB
    Device allocated:		  10.92TiB
    Device unallocated:		   1.00MiB
    Device missing:		     0.00B
    Device slack:		     0.00B
    Used:			  10.90TiB
    Free (estimated):		  15.26GiB	(min: 15.26GiB)
    Free (statfs, df):		  15.26GiB
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)
    Multiple profiles:		       yes	(metadata, system)

Data,RAID0: Size:10.87TiB, Used:10.86TiB (99.86%)
   /dev/mapper/data1	   5.44TiB
   /dev/mapper/data2	   5.44TiB

Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
   /dev/mapper/data1	   8.00MiB

Metadata,RAID1: Size:23.00GiB, Used:21.39GiB (93.00%)
   /dev/mapper/data1	  23.00GiB
   /dev/mapper/data2	  23.00GiB

System,single: Size:4.00MiB, Used:0.00B (0.00%)
   /dev/mapper/data1	   4.00MiB

System,RAID1: Size:8.00MiB, Used:784.00KiB (9.57%)
   /dev/mapper/data1	   8.00MiB
   /dev/mapper/data2	   8.00MiB

Unallocated:
   /dev/mapper/data1	     0.00B
   /dev/mapper/data2	   1.00MiB
