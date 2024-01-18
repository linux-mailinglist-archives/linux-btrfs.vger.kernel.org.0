Return-Path: <linux-btrfs+bounces-1564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651083218E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1802BB21F9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6A28DA1;
	Thu, 18 Jan 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ASwIYIDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1fhCBy5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ASwIYIDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1fhCBy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055D321B2
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617004; cv=none; b=GadPpHUa9oAHuUC+Op60VJn+IUceksMJEtqBlXdikmTZUWoGyaDM5CwYnm/+KK0/6e1ZTsV6FL9yFL7b0B2gmwFjOQbJ0T1mZV3QCvAd572fd0IliNO7HEtXFa7T9fvQ1KcLALn1lcukxhzvSHyl8qg4qc1ZigODQ+HgqhrmFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617004; c=relaxed/simple;
	bh=2qkrj6DZZw4zxALcKvTuJfxyIyb7j4XqYM6J55QfbTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhlM8HnJj93uw2dSsPimkQ9xI7cBlimEWBQVszr+j2bJPJdhzm46Y2QwIDcF9woanlIS2yYMoRtm4y1wnLcRrXLY3URSCBlm1l1Q3YzSBXm24orj+bHs522D7QNhQjeZHUIuVd5HWfTIlodJbrLA8X+pgNLiWbIgk4cqISG07jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ASwIYIDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1fhCBy5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ASwIYIDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1fhCBy5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14BAC21EC0;
	Thu, 18 Jan 2024 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705617001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJV0JAUbkknWuxvMW1Ut6cZeRJ9NaAvzb5ubHkd+GZo=;
	b=ASwIYIDl0hm+hz7g/wv9ghfHxiwDB/e34PWdaHs9izxa8i+TqQrVWocxdy85+m8yh0joIY
	YhlOc6Dl7K+inWS81eANwDh9Sw9eogudw9YxoLXUb4WhCCktCdmL7a3Xv0Bwk3kLr07z6A
	pImMm42vLhKbYOOnE0NxxfFNCjU8MK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705617001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJV0JAUbkknWuxvMW1Ut6cZeRJ9NaAvzb5ubHkd+GZo=;
	b=L1fhCBy5Ocy0U3FO05t90FJnP5CWg8Kh3uafTUBkznTPQ0AG4HVRn4eXyRkZsDJLVTt/2K
	RQCTZKCbiktIugBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705617001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJV0JAUbkknWuxvMW1Ut6cZeRJ9NaAvzb5ubHkd+GZo=;
	b=ASwIYIDl0hm+hz7g/wv9ghfHxiwDB/e34PWdaHs9izxa8i+TqQrVWocxdy85+m8yh0joIY
	YhlOc6Dl7K+inWS81eANwDh9Sw9eogudw9YxoLXUb4WhCCktCdmL7a3Xv0Bwk3kLr07z6A
	pImMm42vLhKbYOOnE0NxxfFNCjU8MK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705617001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJV0JAUbkknWuxvMW1Ut6cZeRJ9NaAvzb5ubHkd+GZo=;
	b=L1fhCBy5Ocy0U3FO05t90FJnP5CWg8Kh3uafTUBkznTPQ0AG4HVRn4eXyRkZsDJLVTt/2K
	RQCTZKCbiktIugBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CC913310;
	Thu, 18 Jan 2024 22:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tGkoAGmmqWVCFwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jan 2024 22:30:00 +0000
Date: Thu, 18 Jan 2024 23:29:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Block size helper cleanups
Message-ID: <20240118222941.GQ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705511340.git.dsterba@suse.com>
 <99eb80c4-4434-4d97-87b8-c4f4e7c3c5cd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99eb80c4-4434-4d97-87b8-c4f4e7c3c5cd@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.17 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.84%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.17

On Thu, Jan 18, 2024 at 02:16:11PM +0800, Anand Jain wrote:
> 
> 
> 
> Sorry for the late comments. Looks good
> 
>   Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> 
> just one nit:
> You may also bring the following repetitive code into a new
> helper function as it is used once in init_mount_fs_info()
> and again  in open_ctree():

I don't think we need the helper here, it's for the one-time
initializations, unlikely to be needed anywhere else that would justify
it.

