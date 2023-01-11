Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC176654B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKGis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjAKGiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:38:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247CFADC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:38:20 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE6L-1pUXhG2RnH-00KjZ6; Wed, 11
 Jan 2023 07:38:14 +0100
Message-ID: <fd3c608c-2665-4efb-b35b-a238e190c609@gmx.com>
Date:   Wed, 11 Jan 2023 14:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 03/10] btrfs: wait for I/O completion in submit_read_bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:602PxZysR6oAmGcL2vOHXEUG9v1C7uucZ6jscQLn1O31VsBbAI3
 J9GmxqPtjeLx3sHCxXIzZmcWw/hnU0d26JC5B/rvUWWlV1SLM3sxJdeypDrC9ZV/4EKLFdC
 y7ST3i1wVerRegJDROEMlsyi2z5UjtQd3Ko/YzAkVmsd4wtijbthDHHLhHSU+bpHUQzCwWk
 0UFUFaCr767kVPOtTp2/A==
UI-OutboundReport: notjunk:1;M01:P0:NoA+dLX2j+A=;50hwbtNuDPu4tt5clTkhtIfjqMc
 ehA0Dy8uWybmmn4J3NaRgLX5XB0AO6AE9SM+zBFNerNtuAQ+zGP6zhKpHJ/sGfKgUIOJj/j15
 G4WJSixFa9yYZe0wHFiGSmXLtLXlwTY9M7nZY9/pUlVS5jhye3GuAY/uC0+D4ppBAG1Ro6IkW
 b1RFPbhbIbXoA6ACDu2LW0TJRx4SXzBm8FLFz9QgF53Kciz5cWVt5EudAr3J0hHl14bn9IyeY
 d9AgAF2LC0Fc172E0JKz51JxxWr7/sRroDMuqUxfexC7nHsOCwEb+/GaMxqvKT+yNvA2gWx88
 6FCLLz4s5myKR9ZsfspS8VaO2oQhBULMTdOiWods9RNxD4HnV1NdmN62rKsxJslLEWiaeUrrP
 YVaSNck0W+v3eLc6DqB8H9o0gIgRlsE5IkZ+3UjmyEfFKr+1tMzGo3YgH6m3Y+co1ZUDFDaML
 FUX9eCL6UdwyAoRvqR/yKYdckXtmmazOBzwVECh5/8iXjOHoBSGp5yDVHYtM7lpcO4qy41uK9
 VyMgp3Eb1KA/K0q3i/f77Myvqb8+sF/Z0KZI09FTNRT/WMfn1LH599QZxLdeeg2d7DzcvNAAk
 ll1fPkxkh+1OX9/OFNxKXRcezXwlqIyw5afyMvpedy82U5iGwWT04cqeAxpI2wAp5fGGeiBzT
 hsfnatIPzYL+1JTMVzAu+xB5v8/FZmrh/UBGgPHZy6N3nvR57pEa0YYU9ymF1aXkdwiOuyHOl
 JEKZQkdytrsFOXK6HD9A2v3esACFF1eX9InNK6Yhss8cBY/SONWofvMJdDY4pPKz3uI/SdJAx
 59vzJLprHC7rvXbVe1jQvh7xnW9HiTzBPL9HXF+d/4v4pQM/FPZ9UQJNZvWC10Zf+L7InTSzV
 a6BTdoOSD31usgkiewvexCbiLvumkRdOf4gHeryWJo6ASOhlQdcUC+EEYRdrHonpjg0uZrKU6
 MY/YtJACnYD/o3BxK0rzTLDkk3c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> In addition to setting up the end_io handler and subitting the bios in
> submit_read_bios, also wait for them to be completed instead of waiting
> for the completion manually in all three callers.
> 
> Rename submit_read_bios to submit_read_wait_bio_list to make it clear
> it waits for the bios as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 0483f70a4fed74..e3fef81a4d96d3 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1490,7 +1490,7 @@ static void raid_wait_read_end_io(struct bio *bio)
>   		wake_up(&rbio->io_wait);
>   }
>   
> -static void submit_read_bios(struct btrfs_raid_bio *rbio,
> +static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
>   			     struct bio_list *bio_list)
>   {
>   	struct bio *bio;
> @@ -1507,6 +1507,8 @@ static void submit_read_bios(struct btrfs_raid_bio *rbio,
>   		}
>   		submit_bio(bio);
>   	}
> +
> +	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>   }
>   
>   static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
> @@ -2009,8 +2011,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	if (ret < 0)
>   		goto out;
>   
> -	submit_read_bios(rbio, &bio_list);
> -	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> +	submit_read_wait_bio_list(rbio, &bio_list);
>   
>   	ret = recover_sectors(rbio);
>   
> @@ -2206,8 +2207,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
>   	if (ret < 0)
>   		goto out;
>   
> -	submit_read_bios(rbio, &bio_list);
> -	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> +	submit_read_wait_bio_list(rbio, &bio_list);
>   
>   	/*
>   	 * We may or may not have any corrupted sectors (including missing dev
> @@ -2785,8 +2785,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   	if (ret < 0)
>   		goto cleanup;
>   
> -	submit_read_bios(rbio, &bio_list);
> -	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> +	submit_read_wait_bio_list(rbio, &bio_list);
>   
>   	/* We may have some failures, recover the failed sectors first. */
>   	ret = recover_scrub_rbio(rbio);
