Return-Path: <linux-btrfs+bounces-7599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45355961B00
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 02:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F1282D9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB12611E;
	Wed, 28 Aug 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wV0P9fEj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7SfV1BJV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wV0P9fEj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7SfV1BJV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972678BFC
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803912; cv=none; b=o8UcM88nz8UsnVJ/7KtiQrDK36eXaaPD1e1eM6Llr2I/S0E7b0B3k3p8RVXezOnafhX8ezLgKGiyiL0C6dhSVNawtvCLF2veUsOPq7wwIE1KEmWoLh3pPr4vira+lEwmBRmvmwF4Z+AaYD+IxSKW7e+I4f3plEpcIRbySRSzjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803912; c=relaxed/simple;
	bh=isM7EaPLnVlJt8mmF3aVkSLhJW5aneRuy8LDtTo9QgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeUc1cv0MlA13ZrOMaGjCCDtbVpclHmB1K8TgrldGjYtMr5CO778Iw8LGfFqahv83yVBmkqeuc58E5U6wZVKik2pHIStNhXjC/mW2u49cQoybmvZFOgKUOPc5slW2IUuEaBaFYTgmMuhK0pkUrQPdZQQeocmIsgLJL3ctv8fbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wV0P9fEj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7SfV1BJV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wV0P9fEj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7SfV1BJV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D339F21AFA;
	Wed, 28 Aug 2024 00:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724803908;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCSCONMnxL358iPHsT5fj68/gjpzfnAxmknvaDQFA10=;
	b=wV0P9fEj87wtYlWXh2Rx9+2AuLlrzjaZuArOVyruBXpJX7bNmwqfSeLOAFtO8iDaWAKJWj
	NRs138gwcaS22QBj3O7OA2meWgftFq3ESOx1otMLVKPxOSsvVFUh+kbARJZzGDpnlUrso2
	NqFohr224effuRUUFE9sCKlKNnEUG0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724803908;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCSCONMnxL358iPHsT5fj68/gjpzfnAxmknvaDQFA10=;
	b=7SfV1BJVKA1aWZ62eBhh8mEsRnut/otSlJ3SC1XaBLOwq27QQnABCCgrX6RtNMO/EVUPhR
	NIl2w39X9xbNpMCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wV0P9fEj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7SfV1BJV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724803908;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCSCONMnxL358iPHsT5fj68/gjpzfnAxmknvaDQFA10=;
	b=wV0P9fEj87wtYlWXh2Rx9+2AuLlrzjaZuArOVyruBXpJX7bNmwqfSeLOAFtO8iDaWAKJWj
	NRs138gwcaS22QBj3O7OA2meWgftFq3ESOx1otMLVKPxOSsvVFUh+kbARJZzGDpnlUrso2
	NqFohr224effuRUUFE9sCKlKNnEUG0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724803908;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCSCONMnxL358iPHsT5fj68/gjpzfnAxmknvaDQFA10=;
	b=7SfV1BJVKA1aWZ62eBhh8mEsRnut/otSlJ3SC1XaBLOwq27QQnABCCgrX6RtNMO/EVUPhR
	NIl2w39X9xbNpMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8B1E1373A;
	Wed, 28 Aug 2024 00:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PD9KERrzmb3PgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 00:11:48 +0000
Date: Wed, 28 Aug 2024 02:11:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] btrfs: clear defragmented inodes using postorder
 in btrfs_cleanup_defrag_inodes()
Message-ID: <20240828001147.GB25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724795623.git.dsterba@suse.com>
 <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
 <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
 <20240827231803.GA25962@twin.jikos.cz>
 <9dd14187-ecae-4633-8823-52269ec8dd70@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd14187-ecae-4633-8823-52269ec8dd70@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D339F21AFA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Aug 28, 2024 at 09:18:11AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/28 08:48, David Sterba 写道:
> > On Wed, Aug 28, 2024 at 08:29:23AM +0930, Qu Wenruo wrote:
> >>
> >>
> >> 在 2024/8/28 07:25, David Sterba 写道:
> >>> btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
> >>> or unmount, but the way it frees the inodes in fs_info->defrag_inodes
> >>> is inefficient. Each time it needs to locate first node, remove it,
> >>> potentially rebalance tree until it's done. This allows to do a
> >>> conditional reschedule.
> >>>
> >>> For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
> >>> convenient but if the reschedule happens and unlocks fs_info->defrag_inodes_lock
> >>> we can't be sure that the tree is in the same state. If that happens,
> >>> restart the iteration from the beginning.
> >>
> >> In that case, isn't the rbtree itself in an inconsistent state, and
> >> restarting will only cause invalid memory access?
> >>
> >> So in this particular case, since we can be interrupted, the full tree
> >> balance looks like the only safe way we can go?
> >
> > You're right, the nodes get freed so even if the iteration is restarted
> > it would touch freed memory, IOW rbtree_postorder_for_each_entry_safe()
> > can't be interrupted. I can drop the reschedule, with the same argument
> > that it should be relatively fast even for thousands of entries, this
> > should not hurt for remouunt/umount context.
> >
> 
> Considering the autodefrag is only triggered for certain writes, and at
> remount (to RO) or unmount time, there should be no more writes, the
> solution looks fine.

Ok, thanks. I'll commit the following updated version:

btrfs: clear defragmented inodes using postorder in btrfs_cleanup_defrag_inodes()

btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
or unmount, but the way it frees the inodes in fs_info->defrag_inodes
is inefficient. Each time it needs to locate first node, remove it,
potentially rebalance tree until it's done. This allows to do a
conditional reschedule.

For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
convenient but we can't reschedule and restart iteration because some of
the tree nodes would be already freed.

The cleanup operation is kmem_cache_free() which will likely take the
fast path for most objects so rescheduling should not be necessary.

Signed-off-by: David Sterba <dsterba@suse.com>

--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -212,19 +212,12 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
 
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 {
-       struct inode_defrag *defrag;
-       struct rb_node *node;
+       struct inode_defrag *defrag, *next;
 
        spin_lock(&fs_info->defrag_inodes_lock);
-       node = rb_first(&fs_info->defrag_inodes);
-       while (node) {
-               rb_erase(node, &fs_info->defrag_inodes);
-               defrag = rb_entry(node, struct inode_defrag, rb_node);
+       rbtree_postorder_for_each_entry_safe(defrag, next, &fs_info->defrag_inodes,
+                                            rb_node) {
                kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-
-               cond_resched_lock(&fs_info->defrag_inodes_lock);
-
-               node = rb_first(&fs_info->defrag_inodes);
        }
        spin_unlock(&fs_info->defrag_inodes_lock);
 }


