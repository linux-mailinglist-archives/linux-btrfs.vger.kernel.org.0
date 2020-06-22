Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A415C2040B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgFVTyn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 15:54:43 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:43455 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728469AbgFVTyn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 15:54:43 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id nSS3jggLWtrlwnSS3jkR7n; Mon, 22 Jun 2020 21:49:56 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1592855396; bh=YLyS9lhvAXprh06rB0bBEmB2r/AOTVOIxskdDgaAKl4=;
        h=From;
        b=Sf+6BplGPbLudXfm447tC38ZyF0yBiAcQZoE8EXTfs9w8/QE5UfNNUa8l4gVNdaDs
         aYyXLdx51XZI+FRW1c3Kt4H7TFJokPeBUJJZLx7nQi/8o4lHfteAzjMwDHNndx9lrT
         3SHZuMsLqBHnxV52Vv9xcifPamSPNiZbchwL5DgTH25Ay4LIdZMEzTNIu55DfAtr5j
         +0VjHEE8r3iAZyKel3B+A1K5R3KM1J83g4tzoNSekwj6V12Metcpu438bQdSR1PMwj
         lK53F/nZN0Cllhkp+oWyg7R0rzldcfkwlolxxxW0mCI1d3sZlSgfCvOcNL3iS4ujYY
         AoRvkIuNCXrmQ==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=HvNiySBuGoZ90GWRqmAA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
To:     dsterba@suse.cz, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
 <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org>
 <20200619131117.GD27795@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <79672577-6189-10fe-b4bc-8cf45547b192@libero.it>
Date:   Mon, 22 Jun 2020 21:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619131117.GD27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPBoR1k/cy9Z3QzL0NDUCLOiOgwaFPDPt0W6UDXV+3oYAwsRkoBcCx6e8/8wGweO/c+gkQrjGdq8E4VSnQ05LwATa/EjbrNLZGrGPV2PKxmJhma5h06o
 KCspHYymaGkL1US5J5/3Cgwru2pw9i4/+Jz/oMMMtt5tw3F+2oreZP68aHZDAgfdrN517xt1E09E4+Zu2K+gJWqDuchbDjdGymmQodg45QE0i4Y86ZZJQBiM
 b9/v7mabbQ1rftzO6isH1+QzmWJNcE19NbhKjXMmQX+icArdK6kO4FV3XR+w37N5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/19/20 3:11 PM, David Sterba wrote:
>> If there wasn't some insurmountable reason
>> why duperemove can't be merged with btrfs-progs, then it would have
>> happened already, so there must be a reason why this can't ever happen
>> (which might be as simple as neither maintainer wants to merge).
> I'm not against adding the functionality to btrfs-progs, but merging
> whole duperemove feature set might not happen due to additional
> dependencies. This would need to be evaluated, but I'm not aware of any
> other technical reasons.
> 
> I don't remember exactly why duperemove started as a separate project
> instead of a subcommand or progs, but we can revisit that.
> 
Even tough I don't think that this was the reason at the time, now the ioctl FIDEDUPERANGE (aka BTRFS_IOC_FILE_EXTENT_SAME) is "filesystem agnostic". So I think that does make sense a tool more generic than btrfs(-progs).

What I mean is: because this is not a BTRFS specific ioctl anymore, why we should have a BTRFS specific implementation ?

 From a technical point of view: dupremover could take advantage of the btrfs csum. So the question could be : is it better to add the capability to use the BTRFS csum to duperemover or to add the code of dupremover to BTRFS ?

 From an user point of view, I think that the former makes sense.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
