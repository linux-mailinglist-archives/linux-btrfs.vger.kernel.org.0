Return-Path: <linux-btrfs+bounces-8901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6599D42B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1641D2881D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB31ABEBD;
	Mon, 14 Oct 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXqu2OV1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wl2gIDSK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXqu2OV1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wl2gIDSK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33000139D0B
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921826; cv=none; b=rJwzFcIW+cPQvpjwHgFuUiNJlDlOadssH63tHQCuK2T6qCg35zBnMwsjK6zR2LZs95WZT5bASy48qCvirTZ+v2Yf3J+W+E/jwPCMAmih/WyuceIJs99/rqMl73zZjRg86eCUwYJ7VsEaHWwvnlPGSXHNyd/QAg0KUDoz9GKzpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921826; c=relaxed/simple;
	bh=DZhKuXtUQPlBL6qwddt5mYL7ovenA65y0j4o6XgVWng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNAY675Pm/GKh87D5KiYZL0cyFTCmTt2BisFBqsBPJ1PKcQTYMIVap+m85MgE9RC3MrDBmtttvmD89BYRweZdz0irVnfKVL18N0xm7brYLyX8OxtN0+t+topYPV2RREKbMxwiRwgAnFGPiWCKlt6AETHY4m5cOKzYmY4+y8NRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXqu2OV1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wl2gIDSK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXqu2OV1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wl2gIDSK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49A3721DB7;
	Mon, 14 Oct 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiBcXFo877ddzdgE3aMVkfTkq5NZee36mBYL86zpv18=;
	b=dXqu2OV1L6oWCYuZfkfwABSp/IZjPoFRwh4eSD3P7mMA0KUDaDqfPluJZhScs/Shc2nL0S
	NTLx0UShKAOr35KQd2iJUHskckuzc3cuplD6W69ELMtq587FQR+OHJ4/w3uT6DsQyQK2Yb
	fb4QhXjZOBNd24f+TJnnV3K3PpKFBiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiBcXFo877ddzdgE3aMVkfTkq5NZee36mBYL86zpv18=;
	b=wl2gIDSK8MlEed+6w4lwJGcnk8s7rIrW3dQJhmFcH0mFpiHvR8glA8S6tcbG4WdVtYVc/h
	l6laqkqjo1mVOuAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiBcXFo877ddzdgE3aMVkfTkq5NZee36mBYL86zpv18=;
	b=dXqu2OV1L6oWCYuZfkfwABSp/IZjPoFRwh4eSD3P7mMA0KUDaDqfPluJZhScs/Shc2nL0S
	NTLx0UShKAOr35KQd2iJUHskckuzc3cuplD6W69ELMtq587FQR+OHJ4/w3uT6DsQyQK2Yb
	fb4QhXjZOBNd24f+TJnnV3K3PpKFBiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiBcXFo877ddzdgE3aMVkfTkq5NZee36mBYL86zpv18=;
	b=wl2gIDSK8MlEed+6w4lwJGcnk8s7rIrW3dQJhmFcH0mFpiHvR8glA8S6tcbG4WdVtYVc/h
	l6laqkqjo1mVOuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3486B13A51;
	Mon, 14 Oct 2024 16:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lwqaDN9ADWesBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Oct 2024 16:03:43 +0000
Date: Mon, 14 Oct 2024 18:03:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use filemap_get_folio helper
Message-ID: <20241014160333.GD1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8c4bff7365deea48db84e5c91af0be3538655060.1728918448.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c4bff7365deea48db84e5c91af0be3538655060.1728918448.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Oct 14, 2024 at 11:11:38PM +0800, Anand Jain wrote:
> When fgp_flags and gfp_flags are zero, use filemap_get_folio(A, B)
> instead of __filemap_get_folio(A, B, 0, 0)—no need for the extra
> arguments 0, 0.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: David Sterba <dsterba@suse.com>

