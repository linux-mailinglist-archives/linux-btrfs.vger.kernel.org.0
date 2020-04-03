Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28919DBBF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404299AbgDCQcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:32:51 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:45933 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404208AbgDCQcv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 12:32:51 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id KPFQjtzmEMAUpKPFQjJ5jo; Fri, 03 Apr 2020 18:32:49 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585931569; bh=68hiHNYPzwh72RV2iehwgY9zVlLw0p56UYedPBcndrc=;
        h=From;
        b=YFlSGKo8uLp+obtr26Lc8wA8xJYZUwK7Y9mpA6dSdYpBgfaVumUZC36kujiqin6kl
         zWPkWLvdenblXgfQWywBj3WJiLk0TFgaDvnEXQjob/bVAoPYu81yqlUxOP8B9JNITT
         Hv1B5tPfmGGFj+kw7Sv9i3gYT4u9V0poC3/oksMFy+GuwmQi7/4MCJoaj6qE3TLlcA
         IwZ2QLE8ysdLvddkxPOTz3nQpiz2Qt7G1kHh4qjrMbis9Oa+f6Q71crq/O3ndGCNl1
         IxuDobSqgsLDgOxAnYM0ZDCTDlLL5x3A3O23kPA+mZ1H2nHta/jcbZR9oL3Lr8y7S9
         YuxeOWWgFSgjg==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=9roxkHM9Xyfm3-Wu0PkA:9
 a=eazlqoZsWr4dPGE-:21 a=8YdAPFjMg2g3NvX-:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
 <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
 <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
 <CAL3q7H7GXpnaK-jPQybi3PfoMJtr7gJQ0tha9fYG-he0vrzdXw@mail.gmail.com>
 <fb1a7773-8166-6ed5-8a63-d3ec86e1a70c@gmx.com>
 <f77f715b-2220-b65d-d42a-7aae81f274f9@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <42de44bd-431c-fe5b-3b23-a3f1b3181d25@libero.it>
Date:   Fri, 3 Apr 2020 18:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f77f715b-2220-b65d-d42a-7aae81f274f9@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD1Vpc95eggycWbV3Vr21vVUbGucUHCdYGfYrHupJZI0K7clW3WOf4NNUgOd/gRCKeVctXkKbuF6RpSgcKZ7vRulszxR7XIGsjZOKP66JK8XuUrGbeER
 MHL1w7VZhZSyCO6XC8gmcBtO0/5jzfLBampz5Oi0LgMjRsfVPdCBmo4JLykaX6PssTuQ6prPHFObRvitaf0SJwdz/+h0q6Df0OcV/2pGUvlGoucGCPL72nMB
 7IyNI+hWiFqY7cMODx/lZ0KGYcFVSIV9QJTck2DdYbPIkYoCNqaaSDlEy4x0vj/X
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/3/20 2:16 PM, Qu Wenruo wrote:
> OK, attempt number 2.
> 
> Now this time, without zero writing.
> 
> The workflow would look like: (raid5 example)
> - Partial stripe write triggered
> 
> - Raid56 reads out all data stripe and parity stripe
>    So far, the same routine as my previous purposal.
> 
> - Re-calculate parity and compare.
>    If matches, the full stripe is fine, continue partial stripe update
>    routine.
> 
>    If not matches, block any further write on the full stripe, inform
>    upper layer to start a scrub on the logical range of the full stripe.
>    Wait for that scrub to finish, then continue partial stripe update.

As you wrote below for a full-stripe write, there is no problem at all.

For a partial update, I think that together to the write request from the upper layer, it must passed the checksum (for the data) and the generation nr, parent... info (for the metadata).
A page (4k) contains the checksum for 4096/32 = 125 blocks; if you cache these checksums likely you don't have to read a further page to perform a rmw cycle.



> 
>    ^^^ This part is the most complex part AFAIK.
> 
> 
> For full stripe update, we just update without any verification.
> 
> Despite the complex in the repair routine, another problem is when we do
> partial stripe update on untouched range.

Due to the nature of a cow filesystem, each chunk can be divided in two consecutive area: the first is the "touched" data, the second the "untouched data". So may be tracking a pointer would be sufficient...
But I think that it is a fragile assumption....

> 
> In that case, we will trigger a scrub for every new full stripe, and
> downgrade the performance heavily.
> 
> Ideas on this crazy idea number 2?
> 
> Thanks,
> Qu
> 

GB
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
