Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E726D8B2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjDEXox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 19:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDEXow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 19:44:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83566E82
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 16:44:50 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Il-1qPQ9L3149-013KyR; Thu, 06
 Apr 2023 01:44:47 +0200
Message-ID: <b7d05323-0d77-41b9-3e5d-ab800e5d6ebd@gmx.com>
Date:   Thu, 6 Apr 2023 07:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 06/12] btrfs: scrub: introduce a helper to verify one
 metadata
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1680225140.git.wqu@suse.com>
 <eb752c34ca23d5d55ce7df9b43cdcb5f52b97490.1680225140.git.wqu@suse.com>
 <20230405152849.GK19619@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230405152849.GK19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GgcQ+LXsMc1WNJTLWItO5U+fvxg9z0voMRQjzlrvGyhxrVtlSEu
 rR6NFRTR8U/Uq09xv6Y9sCNjmB9BR59ylAMoxaQDNnZCc6S1mHLRoWQRwRY2bvQdJgoIJJW
 4iHnYZ+gyf+K1gMsMAK0BOP09A3mITwcuITHrk8glWfZxNQnZA+SZQC2jDXaWZQ9dxKiiCT
 Uuct7EQzqdAbAi1JAdPUw==
UI-OutboundReport: notjunk:1;M01:P0:MjI9nyuWQoo=;wNTOAigI36+ArtDgMXV25UzBdM5
 VdGrKpZlx4vIBnt9zoW4mt4xPwNcHWeSFKhKbWNrZt7NrV1DE/2apRUYO4iGAeburqXNdZRpB
 NW3iwnrzQ9f+mdf2tQ3f9DyZxKOPjvvgLZsTFcJYqam5hvZjuhRcXTbLkxrNoAFqZzRf8Th9F
 O/5+INbD7fxYl1YMtnTlALItWeDn8jQlnfJP46V1HODR/t5S9IeQP18qWpy1zp3gp9C8y/xtK
 Kubb/g7VcBYegZ3IPh4m1G/n0xPot4RYFhOMLwyLNd6Gq+YWh8Ii5moC27ViE9uoauxp7Wqt/
 y/JSfTI0DjhJHt+rsFR6fjYtMQkiThaDTHjNpbCAOid1wmwzld2M+xszV4Dgmkt2ysy7mP7xd
 k+eHCVsTKrBZOFXHPIpMF5nBMDxpYUu9wcqYmTlfbBk0qppnxHPTXjAdrs9EmbmMeZA796wza
 +8i+i+5NoGibAtIWQVcPrdHBshYuUqNSdmSxg4p1JP+uQOLhsUX8s0aUGk7sLleV/iFC0nAuf
 xcyDfCl4wCpPujnLlhjmMW+IvUWQG1qQkwyM6pC57CYMfjlp5tnu6/JkgSXn1EYSx8uQ0dS9A
 7SApGkqIstBEdnPq0H/3i81+9L8te4kitC4qdtHF9QeWRjDV6XRpn6eQBRvyr363WuDSdnNN5
 zW6H+o+GDAr392I0hbDzo7+jK84qU1BqWWj13NTSnLEUlF8UgJBRQK6NEV3j6L7SqAK22v6Ks
 kmrhfpJ6KUd40IWLQU9hQJ8Ug651LIB/RylWURidFSaLuxQdihkYdAaySjboiAft+QrYBlZGk
 mKT2KfcOZpjodjvw00v8zzMlQe2iH7n6PoeKhIIUx3H/CsSpYuOH4SLTfX+hwvm60BXANxbND
 3LvKn8px+eBD1P7QcbyUjBw2yoSzzHaWIAzT8ts1g4WF9RL+uHEsje0u31QrsXBM5Mu8b5Q0S
 yqXSWsSvlmYj6NZ9zVBC603ca+Q=
X-Spam-Status: No, score=-2.1 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/5 23:28, David Sterba wrote:
> On Fri, Mar 31, 2023 at 09:20:09AM +0800, Qu Wenruo wrote:
>> +void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
>> +{
>> +	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
>> +	const unsigned int sectors_per_tree = fs_info->nodesize >>
>> +					      fs_info->sectorsize_bits;
>> +	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
>> +	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
>> +	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
>> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>> +	u8 on_disk_csum[BTRFS_CSUM_SIZE];
>> +	u8 calculated_csum[BTRFS_CSUM_SIZE];
>> +	struct btrfs_header *header;
>> +
>> +	/*
>> +	 * Here we don't have a good way to attach the pages (and subpages)
>> +	 * to a dummy extent buffer, thus we have to directly grab the members
>> +	 * from pages.
>> +	 */
>> +	header = (struct btrfs_header *)(page_address(first_page) + first_off);
>> +	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
>> +
>> +	if (logical != btrfs_stack_header_bytenr(header)) {
>> +		bitmap_set(&stripe->csum_error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		bitmap_set(&stripe->error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		btrfs_warn_rl(fs_info,
>> +		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
>> +			      logical, stripe->mirror_num,
>> +			      btrfs_stack_header_bytenr(header), logical);
>> +		return;
>> +	}
>> +	if (memcmp(header->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE) != 0) {
>> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		bitmap_set(&stripe->error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		btrfs_warn_rl(fs_info,
>> +		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
>> +			      logical, stripe->mirror_num,
>> +			      header->fsid, fs_info->fs_devices->fsid);
>> +		return;
>> +	}
>> +	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
>> +		   BTRFS_UUID_SIZE) != 0) {
>> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		bitmap_set(&stripe->error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		btrfs_warn_rl(fs_info,
>> +		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
>> +			      logical, stripe->mirror_num,
>> +			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
>> +		return;
>> +	}
>> +
>> +	/* Now check tree block csum. */
>> +	shash->tfm = fs_info->csum_shash;
>> +	crypto_shash_init(shash);
>> +	crypto_shash_update(shash, page_address(first_page) + first_off +
>> +			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
>> +
>> +	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
>> +		struct page *page = scrub_stripe_get_page(stripe, i);
>> +		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
>> +
>> +		crypto_shash_update(shash, page_address(page) + page_off,
>> +				    fs_info->sectorsize);
>> +	}
>> +	crypto_shash_final(shash, calculated_csum);
>> +	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
>> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		bitmap_set(&stripe->error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		btrfs_warn_rl(fs_info,
>> +		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
>> +			      logical, stripe->mirror_num,
>> +			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
>> +			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
>> +		return;
>> +	}
>> +	if (stripe->sectors[sector_nr].generation !=
>> +	    btrfs_stack_header_generation(header)) {
>> +		bitmap_set(&stripe->meta_error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		bitmap_set(&stripe->error_bitmap, sector_nr,
>> +			   sectors_per_tree);
>> +		btrfs_warn_rl(fs_info,
>> +		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
>> +			      logical, stripe->mirror_num,
>> +			      btrfs_stack_header_generation(header),
>> +			      stripe->sectors[sector_nr].generation);
> 
> Is return; missing here?

Oh, right we should return or we clear the error bitmap.

Thanks,
Qu
> 
>> +	}
>> +	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
>> +	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
>> +	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
>> +}
