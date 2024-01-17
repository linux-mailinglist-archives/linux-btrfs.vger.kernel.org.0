Return-Path: <linux-btrfs+bounces-1528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D0830D4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E582850D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81E249EC;
	Wed, 17 Jan 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YiyR+KKS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4o9FBpy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YiyR+KKS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4o9FBpy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60804249E0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520105; cv=none; b=OXMZUKDqIgS6UmUj9v4531WMzI3Mm790ZU/2RiTNq6xhaKs4zF/SAZ6Kv5zvH70ZnW9GjtYOM9iV8k5ShJlim6oksDKCaJieMkGt/eYcz/Ll7lNLO7CxzkAaxzOBCdyHdTgEYCRRJMeYruG/8vq/6vBgD292g/hycPrEHWR1ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520105; c=relaxed/simple;
	bh=TKT6HXDnAVcRdOEUkbeZtZgexuD/nn2LlzwgVw82iP4=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Spam-Level:X-Spam-Flag:X-Spam-Score; b=puQhMGUnFzzfBuHo+Ic0sHTsc5U660E8dihSmOiw7DYaZsU6/ryaGVXlsR5N/YTIclFXfb41I2AfLlfRY4OJNd0FxZMfzavxf5/pi4zQx2w4aD0/SsWFN7mbieUOoRxuU5RBQgTViymB3Eto76Ai0tmsg10iYG2qv/yF5xHWQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YiyR+KKS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4o9FBpy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YiyR+KKS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4o9FBpy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00E8A1FCE7;
	Wed, 17 Jan 2024 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705520096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBeBXyq5PDyyu2m1EY2ehnfUExE4G+9lFOTj+KpAxgI=;
	b=YiyR+KKS3QlPDuT6yN/++WZLzsPV/0q/9ZpA8Y7JADTUZ7TycdqlRy+R6PvpAi44sjx7s1
	iiWY77ilNhI7gZv3xBnV4PCAVNeLgkPiQlv76Mk7eKxY3aRJWwkj4Hu49Qv4RMjmHtEQUu
	S0zyb+TgzGj++6XQWo3VNe5/oizSvaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705520096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBeBXyq5PDyyu2m1EY2ehnfUExE4G+9lFOTj+KpAxgI=;
	b=N4o9FBpyq88NveqX7jDsyjGjqUuGGPKuZhoD9S/CxKeuHRld90jTCpuyP9wqkDHGXWX7BE
	3n0zlD8kFp2l/6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705520096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBeBXyq5PDyyu2m1EY2ehnfUExE4G+9lFOTj+KpAxgI=;
	b=YiyR+KKS3QlPDuT6yN/++WZLzsPV/0q/9ZpA8Y7JADTUZ7TycdqlRy+R6PvpAi44sjx7s1
	iiWY77ilNhI7gZv3xBnV4PCAVNeLgkPiQlv76Mk7eKxY3aRJWwkj4Hu49Qv4RMjmHtEQUu
	S0zyb+TgzGj++6XQWo3VNe5/oizSvaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705520096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBeBXyq5PDyyu2m1EY2ehnfUExE4G+9lFOTj+KpAxgI=;
	b=N4o9FBpyq88NveqX7jDsyjGjqUuGGPKuZhoD9S/CxKeuHRld90jTCpuyP9wqkDHGXWX7BE
	3n0zlD8kFp2l/6Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DFFB813482;
	Wed, 17 Jan 2024 19:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2PErNt8rqGUxYwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 17 Jan 2024 19:34:55 +0000
Date: Wed, 17 Jan 2024 20:34:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: parser related cleanups
Message-ID: <20240117193436.GL31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705464240.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705464240.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.12 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.45%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.12

On Wed, Jan 17, 2024 at 02:40:38PM +1030, Qu Wenruo wrote:
> Btrfs-progs has two types of parsers:
> 
> - parse_*()
>   Those would return 0 for a good parse, and save the value into a
>   pointer.
>   Callers are responsible to handle the error.
> 
> - arg_strto*()
>   Those would directly return the parsed value, and call exit(1)
>   directly for errors.
> 
> However this split is not perfect:
> 
> - A lot of code can be shared between them
>   In fact, mostly arg_strto*() can be implement using parse_*().
>   The only difference is in how detailed the error string would be.
> 
> - parse_size_from_string() doesn't follow the scheme
>   It follows arg_strto*() behavior but has the parse_*() name.
> 
> This patch would:
> 
> - Use parse_u64() to implement arg_strtou64()
>   The first patch.
> 
> - Use parse_u64_with_suffix() to implement arg_strtou64_with_suffix()
>   The new helper parse_u64_with_suffix() would replace the old
>   parse_size_from_string() and do the proper error handling.
> 
> Qu Wenruo (2):
>   btrfs-progs: use parse_u64() to implement arg_strtou64()
>   btrfs-progs: implement arg_strtou64_with_suffix() with a new helper

Thanks, that's better than I expected, it's clear what helpers can be
used where just by the name. I did some minor adjustments or added a
comment for the arg_* helper declarations.

