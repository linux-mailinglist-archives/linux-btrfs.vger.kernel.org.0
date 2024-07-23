Return-Path: <linux-btrfs+bounces-6670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3A93A9C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780CE284AC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0161494B1;
	Tue, 23 Jul 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dYWwvlye"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EA13BAD5
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776853; cv=none; b=I6V2usYGJnDa55SbDVaqvjDmWTYZOA1mbm+usvqnoDM+7iWi+buAsyYM3No9hCqCL4Lp/u1mQOQMsiOyhsaZeuUD42Ji3HrMXxyB7aWOsD74SzWAoWKz8gnyFQgDRAV5HTqheZybA6PhZtXOIktkVIbHAQ9ILbY2m295WQ5GQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776853; c=relaxed/simple;
	bh=FZ6qfSJgOutkZK4JcMlBoiGK9cWwifrmS8wp6NbJvyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vERYITpxw79XSfb+j9PQjjmaQJp0QBWdzTGxUZ5jbzqPUUQO7FCUx+hjVMiQ9rLIr8ye9jjbItzOOt19T7uMsc84qZ5b2V3zsulSbq3AmeYbVwPt0SrzWo7S78IAYHJXB62bNWwj5RqBfyp75yexItWTblxB42XTOHHZ7sRjaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dYWwvlye; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-369f68f63b1so16838f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721776848; x=1722381648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eBg+Fds0MJehDDS9BorM06zMnt0FoTrmKUWScqHBu7U=;
        b=dYWwvlye/mfgNi/vPS+CFxPeb0a8kW5Rsi+RL7zORpgCI8mlPfUGIvPeX1+NkFrVSp
         Hyu5PeHTtHhNSFlOfCNNCoAgIgJhEzh38SyH/h4MnjKLFSsr2YaipAmT4Hyrx+mv/ef/
         hJHSl8+3Js0E+CLTcJMUeMqa954PR/6PXYD1g5SEbuQcmi2aFbTzulVO9JU+aa3uabel
         JV0SpGVb2MM9iBe9r4dfRX3eMc2AzZ5vfwRRhoMTi73l9hLKo/VgkkQCrOJM9M68tCea
         55SCTU0PLsxddJQOPy9lX7jd3gePURCEjvS65UL2eZaJcttBXoi4S97ljwDTWRdbHudj
         dsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776848; x=1722381648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBg+Fds0MJehDDS9BorM06zMnt0FoTrmKUWScqHBu7U=;
        b=wBSJGy1uMFDiICsq3/JG+G1ZAWynlCD22T8asUdeK9QR/34t9OunT9j+OlSFMKavgd
         1Uswwi++Y21DINn27DNwsJ+GwuHWB5alDzpXHeypDP/9rbB5deUTW4qnROHFcog6cA8z
         5LrF2Moj6MXYXOz1DQgaBVzTFL85jkpJcBqcVPeXu9A37+uKHEsGJvVTOddS7KEh3aDQ
         b5Fe3QgHeZYcwXnmkLJQ/x+NQ0/dk9fZ6SJ/674e0pFTLE6E0Fcl1ofOL6PHON6nQw48
         E9w9P0evD3PSk5+UQlfp5nEx+IGNHik4Ydv1858q6hPvb+rJgFQIibSAfqjevTfLXYY/
         sGaA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPj6lhoT6uKXPraFLBZHzPMkdO8ZrtGPHAxoC6X4zUpER11jqcOg1rENG+L7cqdT8AmeM9ECQX7umbOp+8XTDbES8/tVWAfAAXik=
X-Gm-Message-State: AOJu0YxBSN2MNaw845K5huIhNcg+Qn8We8bDwS2IZreKEOb+GSUkdyx6
	sGBzq5vYD2C5NAoDdntmkLoOkgp7FoKf/JYBeFWceuSg17mCepqn7mumMnJwDcI=
X-Google-Smtp-Source: AGHT+IE8Birwgtl9q7pnX94ngF9EkY8cDaKrrF8imUhB60P2mg/EkJeKPWxXWl6f6JI4jNNBMpohGQ==
X-Received: by 2002:adf:e2d1:0:b0:367:8383:62e2 with SMTP id ffacd0b85a97d-369f09cb1acmr683704f8f.29.1721776847398;
        Tue, 23 Jul 2024 16:20:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d25f1c146sm4212377b3a.48.2024.07.23.16.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 16:20:46 -0700 (PDT)
Message-ID: <9b323ca5-9078-4c73-a718-681469e3e6f4@suse.com>
Date: Wed, 24 Jul 2024 08:50:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: implement launder_folio for clearing dirty
 page rsv
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1721775142.git.boris@bur.io>
 <070b1d025ef6eb292638bb97683cd5c35ffe42eb.1721775142.git.boris@bur.io>
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
In-Reply-To: <070b1d025ef6eb292638bb97683cd5c35ffe42eb.1721775142.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/24 08:25, Boris Burkov 写道:
> In the buffered write path, dirty pages can be said to "own" the qgroup
> reservation until they create an ordered_extent. It is possible for
> there to be outstanding dirty pages when a transaction is aborted, in
> which case there is no cancellation path for freeing this reservation
> and it is leaked.
> 
> We do already walk the list of outstanding delalloc inodes in
> btrfs_destroy_delalloc_inodes and call invalidate_inode_pages2 on them.
> 
> This does *not* call btrfs_invalidate_folio, as one might guess, but
> rather calls launder_folio and release_folio. Since this is a
> reservation associated with dirty pages only, rather than something
> associated with the private bit (ordered_extent is cancelled separately
> already in the cleanup txn path), implementing this release should be
> done via launder_folio.

Well, the launder_folio() is completely new to me.

But indeed invalidate_inode_pages2_range() calls folio_launder() then
invalidate_complete_folio2() -> filemap_release_folio() -> 
btrfs_release_folio().

Thus we lack the handling for such cases.

> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8f38eefc8acd..c5155981f99a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7198,6 +7198,11 @@ static void wait_subpage_spinlock(struct page *page)
>   	spin_unlock_irq(&subpage->lock);
>   }
>   
> +static int btrfs_launder_folio(struct folio *folio)
> +{
> +	return btrfs_qgroup_free_data(folio_to_inode(folio), NULL, folio_pos(folio), PAGE_SIZE, NULL);
> +}
> +
>   static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
>   {
>   	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
> @@ -10133,6 +10138,7 @@ static const struct address_space_operations btrfs_aops = {
>   	.writepages	= btrfs_writepages,
>   	.readahead	= btrfs_readahead,
>   	.invalidate_folio = btrfs_invalidate_folio,
> +	.launder_folio	= btrfs_launder_folio,
>   	.release_folio	= btrfs_release_folio,
>   	.migrate_folio	= btrfs_migrate_folio,
>   	.dirty_folio	= filemap_dirty_folio,

