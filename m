Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866D4F8FB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiDHHkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDHHkD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 03:40:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF241A5D6F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649403473;
        bh=LKMAblMZxBrGOHevcTFQfvvKHRAo2/WR4Mcio83NwFE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FTcbmKKm6sZdeVigphTP76Hp4pDlW7ZpdCpMu0+KIcIPPasmrDDCTbcseTpwRdmbn
         NC1Mpbf27PWLA45Ux4efQBG6sFj6ZpjWdeiqW9QJ1z2/o4tpq+e4wq+eqbUQTp3a7B
         8csdpcV5wZylRZF4sbFJV9MsccCEl4DJH9cwvfAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b6l-1ndZjZ424z-0084ed; Fri, 08
 Apr 2022 09:37:53 +0200
Message-ID: <8c68813e-3103-c8d4-b77c-10a424b5b387@gmx.com>
Date:   Fri, 8 Apr 2022 15:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/12] btrfs: stop using the btrfs_bio saved iter in
 index_rbio_pages
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
 <20220408050839.239113-13-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220408050839.239113-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NVqenofismEm5zBz0gvIyB97iKllzRe1VFXYaWmKeiY5KWdtcpE
 KpRQ0X/fSAgCrrEDtDuP2OtZZNz90eRhRIvXHFsGDIRwllxg6aZTPygDJceC0OUhQEgPSV8
 g7Ce/61F6Yb8ykkYJ/CjCpO8ESAFbQCUe1W85GomfnGyNgTIM48Q5MLZe6blCMu6SB6gSAx
 zdEejj/263ui2mdRa0NdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OFEs29E9a7w=:GFjV4O/60SYS5trOZfLYMf
 qWKgxCaPk4sCRl3CkqZna4+wYeMSUQaLCVqK8pbRNDvVP/5HGZxw5Pg+d6LOhI+BZ056raX56
 QPVgVb53bFoFCFEVZon9shc8UqLz1ENUc0V+oPopKbQPCZEf2Ib8DhBALLjMlPZN6plHHeLpN
 /j9YqjjplKlyKu1UWKTRwy3ctjO7GS9KtvM2JZukRAui+90ccv9SFXEkUSgALkbdlH+gdANu0
 ImcaDHMDpPyelxUaU91xKPowC95lrZR2CWocepBW43N+6QQvPwT1OHNj8GLqhCbjIYzwonMqZ
 sGoMSSd0k91y7YOFo4Xi4fLEOJdnatJG3dTMM4XAIwx1Iq1Ugy+qLdCsdcPNJ77jqTCy8K9OA
 vwWwxFA7yq2m7UBKGoxf3rl5SsXVhoaikQr780WDMmqr7kWiVu4hn2Yt8mwZepyjsSx1ezf2S
 ivVzuCNlpElINzupRiadqhOnNsKGDpxX1c2R51cMhdJ7s25xnrfknqVzt1uJtQ6qOiv3bi5Sa
 Hqn/63T9ploFdn8852MelRpywHq9HVCCAuRfy4GHanjm23HV4crzBrYS3hOIkVhiJZ1EY1ztx
 8fwtznLfPRS/NO8beevqMk523np0Kwj04tqETwdQsJsO43gd+HS3Nfnfv85QYZBo+JZOjyyWQ
 g3qgGiK6lu7uy+7O0GONVBDRW6UlOA+EfPCAjPgEy1tndd/jNoC0AhalqQzGENeitX5ZGcJw+
 g4exE4lHC3ukgekF1mez5TYkUpbAJeThcQTk1Y4OsiBw1bFeC5g5skXPsJx+442jiZpkudEPk
 AM6k3VQkHmEin82CNvijBmPL1V/UZPPZ+YvSZ1doogaNDfm/jprQpBE1gSl+C6nYs+8giSQE3
 X5pNdS16vvMBMQphbaAVDZXRzRfat+lowPk5b1PGFhLPrb2TQOzPm9Ll4MJh8PZmqOGKcedmj
 UYY8V6QaeB6y/FOvjanWBn+oY/2OZPMe7vgMmVy72kCw01YaASNSXJObHKMb9dlmSOh2rms17
 vaR3qUpnrlDqhMT+HRGfDNZCzHobI0IW7u5voLYBpcn3HNxEPwG9lAXIiTrL7ZeuNsNggU2TY
 FL4UKAoNiCsTsA=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/8 13:08, Christoph Hellwig wrote:
> The bios added to ->bio_list are the original bios fed into
> btrfs_map_bio, which are never advanced.  Just use the iter in the
> bio itself.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact, the bio split at btrfs_map_bio() time will make all endio
functions to only utilize btrfs_bio::iter.
Thus bi_iter will be even less utilized.

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 1ab77d658bf15..adc62a7352b82 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1134,9 +1134,6 @@ static void index_rbio_pages(struct btrfs_raid_bio=
 *rbio)
>   		stripe_offset =3D start - rbio->bioc->raid_map[0];
>   		page_index =3D stripe_offset >> PAGE_SHIFT;
>
> -		if (bio_flagged(bio, BIO_CLONED))
> -			bio->bi_iter =3D btrfs_bio(bio)->iter;
> -
>   		bio_for_each_segment(bvec, bio, iter) {
>   			rbio->bio_pages[page_index + i] =3D bvec.bv_page;
>   			i++;
