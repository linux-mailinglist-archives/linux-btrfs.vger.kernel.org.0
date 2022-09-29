Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A015EED1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiI2FO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiI2FOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 01:14:24 -0400
Received: from sender4-pp-o98.zoho.com (sender4-pp-o98.zoho.com [136.143.188.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946212A489;
        Wed, 28 Sep 2022 22:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664428457; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=H7xscwshorNG8/zsOq9Njs/2kaopCELNQH8r4sLjqZ86P4VoKd1rjQyi5yivPiIJCS+cb1/OgI2G6Q3wnDRULmFYtiZlkfdkp+siu2QvsfWsSExue2QLDxyayZyzwHDkrh2HM50cPx0vHPFmseU9oF2eEVZeyZqtN/eHzVhn5Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664428457; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ow61T+epH9mjb9+Og7p95dadDjvpbk0b5vmOLXxzXeE=; 
        b=TivAMCuwUbe13vksNBppIBy0I4NMkUi3MQp7xjSpjnU+E/OaMINglJczsjkQlugjYFkDVYBS62rbI5IW9aHyH+wndIB35J5APoo7zFvUxEbOIMyudXPn9GF3OmT2QknopkDmAd/n8EJZdcV3cIwyP45HyZn+ZpxohDriDlpOFLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=PuhwrlLMN/v9l80Mv3qn32uZ26+CYdkZoAuLzwq/D+rB+XVQs7/IiyGWb1KBFM9xYmiu8vOyYdYb
    gBELADBHqJ52EAdNELf2XZRmRX5XXw11/Ove+dUNZA99bUdb/yF8  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664428457;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Ow61T+epH9mjb9+Og7p95dadDjvpbk0b5vmOLXxzXeE=;
        b=JekSkDzfH9GTl0HNcPUflPXSUKLmYR6RSYM1BVOmfJoopJQ/syj2hCvQy+MGt3AE
        xkUbwFZwjuTM50CvjZhWupLr+cdWWIeZrDfLwPli6+2c6kx/dz3tx4IGbZDEtI5Bwr0
        fhNUuIO4LKjPc0LtdoqWXpyK+kWl4YrTRkCNj3kc=
Received: from [192.168.0.103] (58.247.201.74 [58.247.201.74]) by mx.zohomail.com
        with SMTPS id 1664428455972627.0589330818905; Wed, 28 Sep 2022 22:14:15 -0700 (PDT)
Message-ID: <32c9fcf2-e1b4-8d31-a1f4-b07b1d5c1dc5@zoho.com>
Date:   Thu, 29 Sep 2022 01:14:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs:remove redundant index_rbio_pages in
 raid56_rmw_stripe
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>
Cc:     stringbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929014402.2450-1-hmsjwzb@zoho.com>
 <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <c4293742-06ba-8720-e2eb-d4d3bc4da044@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

I test this patch with fstests runs ?

Four btrfs cases failed.

	btrfs/219	btrfs/249	btrfs/253	btrfs/254

Thanks,
Flint

On 9/28/22 23:08, Qu Wenruo wrote:
> 
> 
> On 2022/9/29 09:44, Flint.Wang wrote:
>>    The index_rbio_pages in raid56_rmw_stripe is redundant.
> 
> index_rbio_pages() is to populate the rbio->bio_sectors array.
> 
> In raid56_rmw_stripe() we later calls sector_in_rbio(), which will check if a sector is belonging to bio_lists.
> 
> If not called, all sector will be returned using the sectors in rbio->bio_sectors, not using the sectors in bio lists.
> 
> Have you tried your patch with fstests runs?
> 
> IMHO it should fail a lot of very basic writes in RAID56.
> 
> Thanks,
> Qu
> 
>>    It is invoked in finish_rmw anyway.
>>
>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>> ---
>>   fs/btrfs/raid56.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index f6395e8288d69..44266b2c5b86e 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>>       if (ret)
>>           goto cleanup;
>>   -    index_rbio_pages(rbio);
>> -
>>       atomic_set(&rbio->error, 0);
>>       /* Build a list of bios to read all the missing data sectors. */
>>       for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
