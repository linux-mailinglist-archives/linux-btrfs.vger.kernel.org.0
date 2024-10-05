Return-Path: <linux-btrfs+bounces-8569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8383991505
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 09:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E848A1C21CF3
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8784D3E;
	Sat,  5 Oct 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHXcPIa+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652E231C94
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Oct 2024 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728111641; cv=none; b=IR881GptkXQ3jnVeo3nqe9ryMUKGolnBkWwIQ0JkT8X1U3b16MMO/fyallNcqBOf6WQNkR1OKZg4I6VT1z+4LreSg2psEtC7VC0hp1dDwWxh+JQAQpxI23FVo3epectvUp18jvuC7BuaWBrAYPImq9RxIfl/q3OkgYagTrZqWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728111641; c=relaxed/simple;
	bh=tqzYu3dQ/8JcZPLtLoTIPWRnicnyWNj0WY4edke9uEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z7HUPQiHyXa0V2t1okHH1glQlNw/qE0jJ7t1XlNkj7Oj5ziAkEJYnO91zYkf1KpYTGT03xrLS8bFpD0w/UKk+E9aOO2LyO8OvPhXyWk0mh9rUfUQpCWTR05ojcIvlbNFqpdlOWcUmvwRMBCNGfKRiuDdiJO4SVHpJCq8FUel5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHXcPIa+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd3419937so1773508f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Oct 2024 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728111636; x=1728716436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KniokvomDJLmuoSLpOfOe2e8NEFQJ9BErbWaACBx0ZE=;
        b=eHXcPIa+K5cbndVI2E+NEH+Jjx6oJCCAckTK3fm6ElK4tCLAd3sFEGR5F/kPZxav7l
         S67avkMK4hzzUjO87hODQsHf0P8F6f4W7CDQRMYD8YDLou5jMhhMC6y8k7uFEGBgnlmg
         TndymsQ8a298pEKm5BddJgyB6c8jGSYLPEJJIjZ3pf6iuZtSUEuhAOoKLfw+SN3NbdPD
         5DUQ/96m97o869dDY0iAxJBhiSmULIVEW9pxGWmkxuOV90t8tNT+xVFdkkqo8K1Bi9c4
         pzhImUkeK5bOQ/Api5wlYFiD9GvvxlpVtbeda+3nAYc7oAB4tfd3Lhevm/fXl7nVUvh+
         CobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728111636; x=1728716436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KniokvomDJLmuoSLpOfOe2e8NEFQJ9BErbWaACBx0ZE=;
        b=QFz8pvszlUuF8pEKCYUSsYhKs/eTr8bYT3acBFqY6VpjbUSoTclxsGnSmTooRnsiPd
         jo4bWfEvIPvL7t0znJKgsrhTaqtnF6qc0qNwpKxXUjN7QjOhRkl9oL8QIaZTn+Fsj6T2
         EQmILMWUNrNhLCaf6UY9kdcjE51LGUIq/sM+OLKEFtST4Z540hucKLAobhxp6tM/Mgw7
         JZO+M145HFPzUTcFCHvMJa3Mtar+lZRjLOugfnvR8QZ3GSaWHYa+3wIjNkiombfoBJ79
         dOQ6epv0jHrwv50DmhJ8BTqFa58/WMhoWY+Q0TcdqxYecmthcPy/3GYNreu1jQqc0bWN
         iG6g==
X-Forwarded-Encrypted: i=1; AJvYcCWiMF08mdDHa33Ytwk7yGhodtKhYO0qGnY08G3IHTiPE6DcvlLwFiM81j6nfWEWgTcQmoVHjQ1BBTTfpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVr0oAVgBg+W5fqbn74+7zx/F9/caYz251cwSuEBruAgLPV/Vp
	Usd2O6buNnf9Ps4yCmSRu2K3BqKqPVOWXCxGc1zvLyo1pIbuDojMeykw4FgWj6DE0weS+CXWS3r
	V
X-Google-Smtp-Source: AGHT+IF4KbpPr/99lOE7MES6Gl8zrdZq8LiPi1DP0LVuCoGgCAJKTbVbOIwKNS0wNyCpfK54zku+XQ==
X-Received: by 2002:a5d:5f46:0:b0:37c:cc60:2c63 with SMTP id ffacd0b85a97d-37d0e6dab88mr3321748f8f.5.1728111635681;
        Sat, 05 Oct 2024 00:00:35 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930facsm7982125ad.129.2024.10.05.00.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 00:00:33 -0700 (PDT)
Message-ID: <6a34b96c-0b00-46c8-a0e8-69f0028173e4@suse.com>
Date: Sat, 5 Oct 2024 16:30:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/5 08:53, Boris Burkov 写道:
> If you run a workload like:
> - a cgroup that does tons of data reading, with a harsh memory limit
> - a second cgroup that tries to write new files
> e.g.:
> https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
> 
> then what quickly occurs is:
> - a high degree of contention on the csum root node eb rwsem
> - memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>    as readers, but not scheduling promptly. i.e., task __state == 0, but
>    not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> 
> This results in VERY long transactions. On my test system, that script
> produces 20-30s long transaction commits. This then results in
> seriously degraded performance for any cgroup using the filesystem (the
> victim cgroup in the script).
> 
> This reproducer is a bit silly, as the villanous cgroup is using almost
> all of its memory.max for kernel memory (specifically pagetables) but it
> sort of doesn't matter, as I am most interested in the btrfs locking
> behavior. It isn't an academic problem, as we see this exact problem in
> production at Meta with one cgroup over memory.max ruining btrfs
> performance for the whole system.
> 
> The underlying scheduling "problem" with global rwsems is sort of thorny
> and apparently well known. e.g.
> https://lpc.events/event/18/contributions/1883/
> 
> As a result, our main lever in the short term is just trying to reduce
> contention on our various rwsems. In the case of the csum tree, we can
> either redesign btree locking (hard...) or try to use the commit root
> when we can. Luckily, it seems likely that many reads are for old extents
> written many transactions ago, and that for those we *can* in fact
> search the commit root!

The idea looks good to me.

The extent_map::generation is updated to the larger one during merge, so 
if we got a em whose generation is smaller than the current generation 
it's definitely older.

And since data extents in commit root won't be overwritten until the 
current transaction committed, so it should also be fine.


But my concern is, the path->need_commit_sem is only blocking 
transaction from happening when the path is holding something.
And inside search_csum_tree() we can release the path halfway, would 
that cause 2 transaction to be committed during that release window?

Shouldn't we hold the semaphore manually inside btrfs_lookup_bio_sums() 
other than relying on the btrfs_path::need_commit_sem?

Thanks,
Qu
> 
> This change detects when we are trying to read an old extent (according
> to extent map generation) and then wires that through bio_ctrl to the
> btrfs_bio, which unfortunately isn't allocated yet when we have this
> information. When we go to lookup the csums in lookup_bio_sums we can
> check this condition on the btrfs_bio and do the commit root lookup
> accordingly.
> 
> With the fix, on that same test case, commit latencies no longer exceed
> ~400ms on my system.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/bio.h       |  1 +
>   fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
>   fs/btrfs/file-item.c |  7 +++++++
>   3 files changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e48612340745..159f6a4425a6 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -48,6 +48,7 @@ struct btrfs_bio {
>   			u8 *csum;
>   			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
>   			struct bvec_iter saved_iter;
> +			bool commit_root_csum;
>   		};
>   
>   		/*
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cb0a39370d30..8544fe2302ff 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
>   	 * This is to avoid touching ranges covered by compression/inline.
>   	 */
>   	unsigned long submit_bitmap;
> +	/*
> +	 * If this is a data read bio, we set this to true if it is safe to
> +	 * search for csums in the commit root. Otherwise, it is set to false.
> +	 *
> +	 * This is an optimization to reduce the contention on the csum tree
> +	 * root rwsem. Due to how rwsem is implemented, there is a possible
> +	 * priority inversion where the readers holding the lock don't get
> +	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
> +	 * then blocks btrfs transactions. The only real help is to try to
> +	 * reduce the contention on the lock as much as we can.
> +	 *
> +	 * Do this by detecting when a data read is reading data from an old
> +	 * transaction so it's safe to look in the commit root.
> +	 */
> +	bool commit_root_csum;
>   };
>   
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> @@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
>   			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>   				      folio_pos(folio) + pg_offset);
>   		}
> +		if (btrfs_op(&bio_ctrl->bbio->bio) == BTRFS_MAP_READ && is_data_inode(inode))
> +			bio_ctrl->bbio->commit_root_csum = bio_ctrl->commit_root_csum;
> +
>   
>   		/* Cap to the current ordered extent boundary if there is one. */
>   		if (len > bio_ctrl->len_to_oe_boundary) {
> @@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>   		if (prev_em_start)
>   			*prev_em_start = em->start;
>   
> +		if (em->generation < btrfs_get_fs_generation(fs_info))
> +			bio_ctrl->commit_root_csum = true;
> +
>   		free_extent_map(em);
>   		em = NULL;
>   
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 886749b39672..2433b169a4e6 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>   		path->skip_locking = 1;
>   	}
>   
> +	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
> +	if (bbio->commit_root_csum) {
> +		path->search_commit_root = 1;
> +		path->skip_locking = 1;
> +		path->need_commit_sem = 1;
> +	}
> +
>   	while (bio_offset < orig_len) {
>   		int count;
>   		u64 cur_disk_bytenr = orig_disk_bytenr + bio_offset;


