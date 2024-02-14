Return-Path: <linux-btrfs+bounces-2374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4F85436F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2840B2260F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB211716;
	Wed, 14 Feb 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3+Q1akR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c2qs+NDO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+8IxVxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ne44OUBy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB0111B0;
	Wed, 14 Feb 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895817; cv=none; b=uWy0/dslCQxZp8SMc6EggSj3HiydorroHnM9pi57969kOOuMiqhJZao9uN7SFtnYs/MQDietcBSM4NAmSgytDCZ3eEhSTzoH1twPVJr1KMTDA8Xdg8QG1zypHXQKDUKWxvP2ONtgqt45bgPXQKIMDitJrz3v1GeQUqPW3nkSdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895817; c=relaxed/simple;
	bh=h/HJdVWhBe7KNKmXLFxf+nH5k0PyqXWWQjFTeyZSBUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrQ7R3H6Ce2HO2LLgimIidWxBPR6JX0vPpzgmjzNR6lygWfSXAlADwPLefI99u6SHvI60cQkz1vqydw3tNGE93sn4G0iY++81KypAaF9SbQmQ6GPCGj8QpKRhac12K3drdfSsdKknVJ3aBiS4XxN33TUDWwB5rDkk6sixSPVRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3+Q1akR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c2qs+NDO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N+8IxVxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ne44OUBy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDA3E21B3E;
	Wed, 14 Feb 2024 07:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MG3lyq/Sv9dHZGxrAhUJL4BKP0D+6YiFnkcapsju9dw=;
	b=O3+Q1akR+VgZCr2vKONNPS1snikvZA7vs+sX7B16F3IO5e+RVFJ7Xshq/8hSgaT4E8MtSG
	5Oy7Acw8W7TrMjEmR20hvPsrBIWKoAHZIRKfT36AyccxT5sPRG2CaPs+2IUf2dwuXIqVYq
	JQvnxERGZQHI4tagrVzpXnCoqYRi/gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MG3lyq/Sv9dHZGxrAhUJL4BKP0D+6YiFnkcapsju9dw=;
	b=c2qs+NDOoB/KatkkvfMgokjWvotodewlxMim18VIS3oukUEg27r8tZ1Q74GAafBGqcdUq/
	2vKmjcV4Umz4Z8CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MG3lyq/Sv9dHZGxrAhUJL4BKP0D+6YiFnkcapsju9dw=;
	b=N+8IxVxbjeSfmrichjlDa2mOneaDu0IAtgEI+HzePgrog+Hl43AiXBI0hC3djm/XxQPgWf
	OBF8E847Jy34ZUtf1I7Rnsiq43Pgc+xhaY5X7edhaj1F90ENEkHMOnTHzurwx3QW8ctM73
	F8qbjHO0BpOezgoydpMm3dv0t3KoMKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MG3lyq/Sv9dHZGxrAhUJL4BKP0D+6YiFnkcapsju9dw=;
	b=ne44OUBykqfeMhwQrEnXj6Z4EGJWUCJqQgZ7XogMwdB3hHR2rExXlxInY9CENj9F/z2V1o
	Orofxh6BHZgkfaBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BCEA313A1A;
	Wed, 14 Feb 2024 07:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9I/4LQRszGViLgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 07:30:12 +0000
Date: Wed, 14 Feb 2024 08:29:31 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	HAN Yuwei <hrx@bupt.moe>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Message-ID: <20240214072931.GN355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
 <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
 <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150c409-f2ed-4e5a-a2b6-9f410fb7aff5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N+8IxVxb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ne44OUBy
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bupt.moe:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.85%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: CDA3E21B3E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Feb 12, 2024 at 08:20:21PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/2/12 20:15, Johannes Thumshirn wrote:
> > On 12.02.24 06:16, Qu Wenruo wrote:
> >> Reported-by: HAN Yuwei <hrx@bupt.moe>
> >> Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe/
> >> CC: stable@vger.kernel.org # 5.10+
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>    fs/btrfs/disk-io.c | 3 ++-
> >>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index c3ab268533ca..85cd23aebdd6 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -3193,7 +3193,8 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
> >>    	 * part of @locked_page.
> >>    	 * That's also why compression for subpage only work for page aligned ranges.
> >>    	 */
> >> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_is_zoned(fs_info) && is_rw_mount) {
> >> +	if (fs_info->sectorsize < PAGE_SIZE &&
> >> +	    btrfs_fs_incompat(fs_info, ZONED) && is_rw_mount) {
> >>    		btrfs_warn(fs_info,
> >>    	"no zoned read-write support for page size %lu with sectorsize %u",
> >>    			   PAGE_SIZE, fs_info->sectorsize);
> >
> > Please keep btrfs_is_zoned(fs_info) instead of using
> > btrfs_fs_incompat(fs_info, ZONED).
> 
> At the time of calling, we haven't yet populate fs_info->zone_size, thus
> we have to use super flags to verify if it's zoned.
> 
> If needed, I can add a comment for it.

Yes please add a comment the difference is quite subtle.

