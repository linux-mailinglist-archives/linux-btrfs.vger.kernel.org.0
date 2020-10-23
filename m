Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D106297690
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbgJWSME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 14:12:04 -0400
Received: from smtp-18.italiaonline.it ([213.209.10.18]:60824 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754347AbgJWSMC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 14:12:02 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 14:12:01 EDT
Received: from venice.bhome ([94.37.195.85])
        by smtp-18.iol.local with ESMTPA
        id W1PmkIJQgl7OPW1Pmkjxql; Fri, 23 Oct 2020 20:03:48 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1603476228; bh=yji1Ndhur4+Spb8cjg6vs2WJbCqk9nOmPlqWyvMTpjo=;
        h=From;
        b=f9+yuVpTPUkbrbE7cYKIfHot8utaKN0i0GB6NRHqj5GD0jJjJlpfJDSi3CVZfD1H+
         QHuvZJLQ/niv8NYvhm4fUv6v+1+Jn5eM6PKf9Af28W2ELXjArdUs1TW+N9rpITrYp8
         j8aPaGa1VJu7jGDIaAgh9RE5xAYmgyyXr7UvL6aauAMo4GqEM3K02ojKWEWmZA4jND
         mJStiNYlZweWGGFPhdutbQnKYzbXj9XONfdJracWzAlZkF8iDOKnkP+05d49TuZUIa
         cGHgYXbMUyIRQ9PgEo26cREdF4s3X7Mtdr5E3FjbKvDNBUCCcpvrjn9YOlLDpORcCN
         Bqs1jwDISi0mQ==
X-CNFS-Analysis: v=2.4 cv=VL9jI/DX c=1 sm=1 tr=0 ts=5f931b04
 a=6i7ZtOMYC9jVyZJnprbtYA==:117 a=6i7ZtOMYC9jVyZJnprbtYA==:17
 a=IkcTkHD0fZMA:10 a=Uq0mbvy6AAAA:8 a=sdK8d4-gv52Gl7UXjNgA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=zjBGrzsAejBq38bA:21 a=MFwnZ60OhwntQLdV:21
 a=QEXdDO2ut3YA:10 a=9nAYT2xhiIK_ZOnRzmc7:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Adam Borowski <kilobyte@angband.pl>, linux-btrfs@vger.kernel.org,
        Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20201023101145.GB19860@angband.pl>
 <d7ee1c25-ceea-0471-9702-0622a5ef4453@gmx.com>
 <20201023203742.B13F.409509F4@e16-tech.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <4276e368-411e-8037-9162-c4d2b906c5d2@libero.it>
Date:   Fri, 23 Oct 2020 20:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023203742.B13F.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMecGqq/izXfdAVAAoL7B+DzyDHvec6bCxDupoqmzudTGZUAaRxdyxJcFTRAnLGDZKEiGcCIIZaNM9tgfbvkvwjQQv+gLqVEEhtuYWX9u/NVlivDTSM8
 Sl16cBmsT6LH+m1tJQ9beMZH+rL4dDwcwOcz/VLgTcN4RBwlawSzXyZYwsOPKQWLRd3Oxb5STDtjdLqARnjy7SICjUo0CrDnpKXeXW3rokH8gJa05uX70DXW
 +ZFpzACPpxdGPKMPocULYq3HsfVExNFrEASUpLc63MYSPBq7APxD77WlllQStc6x9xKv7yuO/+5ShEZaYZMVrYHWar2Nw4rLztMKA0EMhjq4JpVe5G7eoA3q
 Ou2Jf9nFcbz4hQUPDq00h2r4r1tRdrBuG+st/WwIdN8fUtyeaAlg8KG55ihyHmlNr4bUzV9m
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/23/20 2:37 PM, Wang Yugui wrote:
> Hi,
> 
> Can we add the feature of 'Storage Tiering' to btrfs for these use cases?
> 
> 1) use faster tier firstly for metadata

My tests revealed that a BTRFS filesystem stacked over bcache has better performance. So I am not sure that putting the metadata in a dedicated storage is a good thing.

> 
> 2) only the subvol with higher tier can save data to
>      the higher tier disk?
> 
> 3) use faster tier firstly for mirror selection of RAID1/RAID10

If you want to put a subvolume in a "higher tier", it is more simple to use two filesystems: one in the "higher tier" and one in the "slower one".

Also what should be the semantic of cp --reflink between different subvolumes of different tiers ? From a technical point of view, it is defined, but the expectation of the users can be vary...

The same is true about assign different raid profile to differents subvolumes....

Let the things simple.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2020/10/23
> 

BR
GB
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
