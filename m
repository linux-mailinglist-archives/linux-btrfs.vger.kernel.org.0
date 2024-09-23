Return-Path: <linux-btrfs+bounces-8168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA997ED0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42002281C9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488219F112;
	Mon, 23 Sep 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxYGa3yW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s4AK6itM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxYGa3yW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s4AK6itM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84C19E993;
	Mon, 23 Sep 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101202; cv=none; b=jGwCTVtSXDgwgYE5lc7hZ8teekQ/VynZFheBjLmyWbtN1pwlGQ9pOAtw5ViQbxzT+fVxZcOOngVuDDkmtssTHQ+TmSEfgMEw+0hZeVZiaYoK02wAgq0s2CMHk5Bxu66a4LUirPuckJse40Mp2Zx98fiOOW6pdWv4bBmeSmpLmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101202; c=relaxed/simple;
	bh=IamA9VXOZThSdOw4061uDlSVFqLEpBsHgQ+wb4xP+vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz3H9YPybTMCuLpW868B94IFy/zNIrycbXQgdP24dC4cF8TtMx/JWLdnaXlXfe+NEGee+7pxip6z1ymBmPUBBnAYSqwL/PLQWe5qx7LouYeDfb+V8WeI9Lb4sFc7c6qvRYu6Vm4mj405TyGTG8+NuN/K/QQQU0D/bpUlaQxy81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxYGa3yW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s4AK6itM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxYGa3yW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s4AK6itM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F283721DDB;
	Mon, 23 Sep 2024 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727101199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9K5eCzdd4BEW/VRC2G61gaq8ZXLYhpSqmek7gKOb50=;
	b=RxYGa3yWbKgP9rEVGeJJMilfk5Tw5MOKl8LdbK5YXV8zOQWju1Ywg78siigceqnVlMMQe4
	OqazBDs1xyePxA6Bvqe9GcwtL/RayLTxIhnafkDKnFzvkk0ZYfoSjX5hsfj8szuV7MNp0B
	cenOxEGSylmKURz7HaE+BqNZsYIB25o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727101199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9K5eCzdd4BEW/VRC2G61gaq8ZXLYhpSqmek7gKOb50=;
	b=s4AK6itMJUPY2HhaKDrp1s60F42QJJpQUZmH8MxGaUVDBZJSBJEwsTr/2XAOjPGtwgpzV6
	uYXTFObgaelOU7Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RxYGa3yW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s4AK6itM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727101199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9K5eCzdd4BEW/VRC2G61gaq8ZXLYhpSqmek7gKOb50=;
	b=RxYGa3yWbKgP9rEVGeJJMilfk5Tw5MOKl8LdbK5YXV8zOQWju1Ywg78siigceqnVlMMQe4
	OqazBDs1xyePxA6Bvqe9GcwtL/RayLTxIhnafkDKnFzvkk0ZYfoSjX5hsfj8szuV7MNp0B
	cenOxEGSylmKURz7HaE+BqNZsYIB25o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727101199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9K5eCzdd4BEW/VRC2G61gaq8ZXLYhpSqmek7gKOb50=;
	b=s4AK6itMJUPY2HhaKDrp1s60F42QJJpQUZmH8MxGaUVDBZJSBJEwsTr/2XAOjPGtwgpzV6
	uYXTFObgaelOU7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D08E713B06;
	Mon, 23 Sep 2024 14:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lb1zMg558WZeYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Sep 2024 14:19:58 +0000
Date: Mon, 23 Sep 2024 16:19:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] btrfs: Correct some typos in comments
Message-ID: <20240923141957.GE13599@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240923065833.12046-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923065833.12046-1-shenlichuan@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F283721DDB
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 23, 2024 at 02:58:33PM +0800, Shen Lichuan wrote:
> Fixed some confusing spelling errors, the details are as follows:
> 
> -in the code comments:
> 	filesysmte	-> filesystem
> 	trasnsaction	-> transaction

Strange that codespell does not find the typos. We also want to fix
typos in bigger batches so please check for more, my quick search gives

block-group.c:2800: uncompressible ==> incompressible
extent_io.c:3188: utlizing ==> utilizing
extent_map.c:1323: ealier ==> earlier
extent_map.c:1325: possiblity ==> possibility
fiemap.c:189: emmitted ==> emitted
fiemap.c:197: emmitted ==> emitted
fiemap.c:203: emmitted ==> emitted
transaction.h:36: trasaction ==> transaction

