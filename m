Return-Path: <linux-btrfs+bounces-666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C5805C5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138281C21076
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EF6A32D;
	Tue,  5 Dec 2023 17:50:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC4122
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 09:50:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96A841FBA5;
	Tue,  5 Dec 2023 17:50:05 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7836B13924;
	Tue,  5 Dec 2023 17:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ir7tHM1ib2VfSQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 17:50:05 +0000
Date: Tue, 5 Dec 2023 18:43:15 +0100
From: David Sterba <dsterba@suse.cz>
To: kreijack@inwind.it
Cc: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Message-ID: <20231205174315.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
 <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.64 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(0.45)[0.150];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[inwind.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 5.64
X-Rspamd-Queue-Id: 96A841FBA5

On Tue, Nov 28, 2023 at 09:00:06AM +0100, Goffredo Baroncelli wrote:
> On 27/11/2023 12.48, Anand Jain wrote:
> > 
> > 
> > On 11/25/23 09:09, Anand Jain wrote:
> [...]
> >> I am skeptical about whether we have a strong case to create a single
> >> pseudo device per multi-device Btrfs filesystem, such as, for example
> >> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
> >> will carry the btrfs-magic and the actual blk devices something else.
> >>
> >> OR for now, regarding the umount issue mentioned above, we just can
> >> document it for the users to be aware of.
> >>
> >> Any feedback is greatly appreciated.
> >>
> > 
> > How about if we display the devices list in the options, so that
> > user-land libs have something in the mount-table that tells all
> > the devices part of the fsid?
> > 
> > For example:
> > $ cat /proc/self/mounts | grep btrfs
> > 
> > /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3  0 0
> > 
> 
> When I developed code to find a btrfs mount point from a disk, I had to
> consider all the devices involved and check if one is in /proc/self/mounts.
> 
> Putting the devices list as device=<xxx>,device=<yyy> doesn't change anything because
> the code has to manage a btrfs filesistem as "special" in any case.
> To get the map <btrfs-uuid> <-> <devices-list> I used libblkid.
> 
> I think that a "saner" way to manage this issue, is to patch "mount" to
> consider the special needing of btrfs.

This sounds like a good option although it needs a special case, but as
you say parsing the devices in the mounts list would be needed a spcieal
handling anyway.

I'd rather not put all the device paths to the listed mount options
though, feels like a wrong place for that.

> Pay attention to consider also events like, removing a device, adding a device:
> after these events how /dev/disk/by-uuid/ would be updated ?

The by-uuid links are another place that would need to be reliably kept
in sync with the changes (add/remove/replace device) as it's a
cache and depends on the events. Caches can get stale, events lost. If
we can get a solution that is based on a run time detection/analysis and
does not even depend on what kernel module publishes as the main device
I'd say we can achieve the best result.

