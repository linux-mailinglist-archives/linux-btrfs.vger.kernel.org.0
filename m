Return-Path: <linux-btrfs+bounces-671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E8805EC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856F2281839
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E646ABA3;
	Tue,  5 Dec 2023 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="I/g1xAlO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVXes3Ny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA655A5
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 11:46:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 28E623200BFB;
	Tue,  5 Dec 2023 14:46:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 05 Dec 2023 14:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1701805559; x=1701891959; bh=V4
	Z7ycR30Y2BSU29IIriaCb0cxsla7O9GNq9hiHdMSo=; b=I/g1xAlOkr4Tbp0HDm
	e8pExO0KxlO0sVlXxNGkmH0kkzGwVxeV198lKdfZ7S4wsO/bOU/9FRJ0X/WrjLpn
	xmKeLmOD3rp59Jn8kHOE/RXYuLWmzXfu1HI/3Dif6cmkB1mei8EGAYPmFXtdkB8R
	5YnrcM4KbQiosxNEj2BzqnNujNECYCE/sUKRjzvWBxWarGC+zA5EVpvS8tThp5rz
	/H8O+9Iv6gGg9PTJDrwV9DnIIjHdiQhpyNMbP7XFy/ayZQs5Fkoh2tK7am6QEmft
	MAzkDev1mBsA/2kY7agJ3vLY0Eke0z6DX3ovwmrnGwnoBWkqv1QrooH17gQHL2GT
	FQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701805559; x=1701891959; bh=V4Z7ycR30Y2BS
	U29IIriaCb0cxsla7O9GNq9hiHdMSo=; b=PVXes3NyqaCHLdST7e9P49xDaeNGH
	P0nAyWbYelNDw6K7nQmo/EYVnW1lKepvsPeHc1+ivAmyRHhTAds4ELMFm20etQ+r
	vhdZ/j0GMbSKm15NFPeeVDJBkK3Jv/bRiUWU/xRb5l2GUlvV9Fd0idxP3w8DCZUj
	SHgYm3JP0m+0/L9cOFJakXthjSd0x4CyrWLlmAniv3j8XF2InyH041GUztxIPvZw
	jCTTEihsHYCifzGu+OmfH/rsg4T4GCwVPOZcwNZFfO0h7BQ0jyXiIAyI0mqM74n2
	5VdDn2TYhMImg9niZURbe2phY6pwnE953zykwDppgWZkuSNw0QkEQ+ciA==
X-ME-Sender: <xms:931vZfaSX9A4yG3mpIBPd5orQoYfzC9rUNgQSv4iEb1KncaX1_uOGQ>
    <xme:931vZeayeK1jiX2niNCSfcJwajLbDJgjHP4Toz3YEfctW4LLmLbFUqOc06TJEIxX7
    Cmx5AYQPjbcoT4Pvoc>
X-ME-Received: <xmr:931vZR8oh6QNyl-KRIhYfqSBcNik4J8NTZREHpyswhRKor5PgOh2NETPbGs2bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:931vZVpbD59LLu9I6Ui0tWHBts6U2pjuhCxVZpKhYYsukcw7ILWF_A>
    <xmx:931vZaqF2AQ1SFoaSxfcTB-4-v0h_wp8ECvepO8Q-C5lJGjvo3C_jQ>
    <xmx:931vZbRB5r1iOaL1FokovBmrtf3O_GUgnR9aaqdROBzFq5arpmUyBA>
    <xmx:931vZfC3EEBoUEhiZUAhh7BjmBnagdYKgXToEGS5JSkaJ-zJJiPN1Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 14:45:58 -0500 (EST)
Date: Tue, 5 Dec 2023 11:45:52 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] btrfs: free qgroup pertrans rsv on trans abort
Message-ID: <ZW998EXZnj4OwDqJ@devvm9258.prn0.facebook.com>
References: <cover.1701464169.git.boris@bur.io>
 <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
 <20231205142732.GE2751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205142732.GE2751@twin.jikos.cz>

On Tue, Dec 05, 2023 at 03:27:32PM +0100, David Sterba wrote:
> On Fri, Dec 01, 2023 at 01:00:11PM -0800, Boris Burkov wrote:
> > If we abort a transaction, we never run the code that frees the pertrans
> > qgroup reservation. This results in warnings on unmount as that
> > reservation has been leaked. The leak isn't a huge issue since the fs is
> > read-only, but it's better to clean it up when we know we can/should. Do
> > it during the cleanup_transaction step of aborting.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++++
> >  fs/btrfs/qgroup.c  |  5 +++--
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 9317606017e2..a1f440cd6d45 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4775,6 +4775,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
> >  	}
> >  }
> >  
> > +static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
> > +{
> > +	struct btrfs_root *gang[8];
> > +	int i;
> > +	int ret;
> > +
> > +	spin_lock(&fs_info->fs_roots_radix_lock);
> > +	while (1) {
> > +		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
> > +						 (void **)gang, 0,
> > +						 ARRAY_SIZE(gang),
> > +						 0); // BTRFS_ROOT_TRANS_TAG
> 
> What does the comment mean?

Oops, I forgot about this. BTRFS_ROOT_TRANS_TAG is a #define in
transaction.c, so it wasn't visible here in disk-io.c. I should move it
to some header they both include. Based on the other stuff in there,
btrfs/fs.h looks reasonable?

