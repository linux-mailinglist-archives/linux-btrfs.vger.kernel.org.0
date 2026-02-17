Return-Path: <linux-btrfs+bounces-21735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBvwIrPmlGmjIgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21735-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:07:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13011514B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3344303FF1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49948313531;
	Tue, 17 Feb 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rffh7bxi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CA313272
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366001; cv=none; b=SijBBwLZnf6lLTzvh8SgOFz7j0mnbqcuaDjF4lqU9tsXjh42tAADjq64mpg5xYUiuBRhXvlkBBSUE5KtRPO2fvGnyXa+9xhOqQCYDzj9NOS5e8nD/jQYLQCUWJX7aFgqapznEqyanU2IxeI1o6LsKrPA9u/wh8h2AaynXuw4tYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366001; c=relaxed/simple;
	bh=j7N2Z+ckZ5XmzUmocAbFRqWKBCixHpkeYSzjNjpwHFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2P7ma2UPi8CVkvx5T+WsELwSk0nH8xSq+yi6sU7hPnBkEGJrBF5K4XpJdPRg5JGp/jQyjr+HNtb9G9ZfIcu1Yo3bGT3g4JPNLLNUT+DNMjdPgqeYf46v3Kq2fdrT0dYtisiDJ2W94u+QOYzcG2llRVHnChAGrcXewyYmeRytXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rffh7bxi; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-794fe698e36so42536347b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 14:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365999; x=1771970799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqcGqaIkklgbx3dyQ9j/9DO0ik21trnwKGw6EXRlK3s=;
        b=Rffh7bxi4AQji5eSQ8jtq+WZ3a+5NtCQnwLsmjnW/dnIXJGedg9vaJzHPz1TPTMUV4
         1jkTGpbJvjKr5RHxJGyleWlkjbFE+Bw7cETxyt0obZnNTbEP+Us4uXX841dNl++H9jmz
         7UPd5nSJBdHnMKY8wToTvNRt9jB24ZYxQRkWlfEaYCKgkq1VT5rNAvYfBqUEUaMfhb/c
         POapbdUJ4IdrzHkZzYvwqAE0xSMv50WZFzv7f+ZaI4As/LRcqm/NBSzMNLjFBXyXgB93
         ih4z2polBw12GAFjsJ1vmPZuReNF8ltgua7tR4Ep7etS86oShv9wzhs46h3LXBf2I8uW
         bJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365999; x=1771970799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqcGqaIkklgbx3dyQ9j/9DO0ik21trnwKGw6EXRlK3s=;
        b=XPIsotLYrIP71wWbkxnqn4Ps1MGX5aJobWiOOGSHstJvmZutCAXk6o8izzEVq+DidH
         OtUYK4gjTaWPD/EWYMXexy620IfeXzYjUep7azdS3yGxH17EHiKkKjoqK0sfx5t5e5fU
         XWNStTLdLExOww/SoFhjThSzxnD6BDKQcCz97OFPGRSx6pBx5FYZUGNxBG8ZHbN+UhQ0
         i3sjXHO5dhGuNilYJ20hJr79rC65yPFoz/g8NkwFSBtaukfw68nPAdVNit6dSAo4GkLg
         2Pnw/ixNwrYksKzFzjFEQNM5gm1XzJS9gHM84O44Xuz3irOzBunbYmlamNYJeAoeLBJ8
         i+BA==
X-Gm-Message-State: AOJu0YyoPP6WhsELvhuzBZPN1S8kdM+4NJkarZiqJc0DKtWwvr45P5Rk
	ROPBC1YuCyWk9q7S98vtLK0QdcQ1ZU6jRl5v26MkMRm1jzUZXL7ovyQC
X-Gm-Gg: AZuq6aKy2k9141PZW7v9XcpukIT7jyRMRI8KPCpiRMsQFwsmMxfBUo5u3QLkrZ16cN3
	x6auk/8tifNrnRZCgl3vYa9RULy/9LxLae8a3g1hUeJh8d97ygPKkN9h0DbAJFEvCG+Duv405zP
	nQvphKlOBFA+aF3WU85wPeN1ApNSJ68Fq+fI6RC46jmYIH48uFo1E2Rhj3/i4ZqtE19IN0G8zjz
	W2kUHjh01THUHR9asfpTPtCcApZ7NPvpFEqMZpn38xpytHLq66bmZe5+PZSqmzwozJqqUfu8YKR
	FSwggLyo3Cfzgt99D/+fbh3R0h0yNpNhV0RTtoMAIsHg/yjsmbWeooraqL5BzySIQwgpM7C2tPi
	yLfCY5pJWkXtBIuBfYaPN3h2afSNCLQ09IAeNSFhhzp5JiPjb0yO6z6ntP+2tsUw14pFerPAX1C
	Wk1Ylw5dN4vQ8PcFIYXA==
X-Received: by 2002:a05:690c:385:b0:796:9c2a:d657 with SMTP id 00721157ae682-797a0c0a937mr112982697b3.10.1771365999475;
        Tue, 17 Feb 2026 14:06:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm116941667b3.36.2026.02.17.14.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:39 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] btrfs: add tracepoint for COW amplification tracking
Date: Tue, 17 Feb 2026 14:06:35 -0800
Message-ID: <20260217220637.820818-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H5X2JmkDX7qXxbmaHQCCtFt8f4niqhiKxERfPZyL2Cwcg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21735-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F13011514B3
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 12:40:04 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Fri, Feb 13, 2026 at 8:37 PM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > Add a btrfs_search_slot_stats tracepoint to btrfs_search_slot() for
> > measuring COW amplification.
> >
> > The tracepoint fires when a search with at least one COW completes,
> > recording the root, total cow_count, restart_count, and return value.
> > cow_count and restart_count per search_slot call are useful metrics
> > for tracking COW amplification.
> >
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/ctree.c             | 15 +++++++++++++--
> >  include/trace/events/btrfs.h | 26 ++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 55187ba59cc0..1971d7bb5f60 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2069,6 +2069,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >         u8 lowest_level = 0;
> >         int min_write_lock_level;
> >         int prev_cmp;
> > +       int cow_count = 0;
> > +       int restart_count = 0;
> >
> >         if (!root)
> >                 return -EINVAL;
> > @@ -2157,6 +2159,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >                             p->nodes[level + 1])) {
> >                                 write_lock_level = level + 1;
> >                                 btrfs_release_path(p);
> > +                               restart_count++;
> >                                 goto again;
> >                         }
> >
> > @@ -2172,6 +2175,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >                                 ret = ret2;
> >                                 goto done;
> >                         }
> > +                       cow_count++;
> >                 }
> >  cow_done:
> >                 p->nodes[level] = b;
> > @@ -2219,8 +2223,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >                 p->slots[level] = slot;
> >                 ret2 = setup_nodes_for_search(trans, root, p, b, level, ins_len,
> >                                               &write_lock_level);
> > -               if (ret2 == -EAGAIN)
> > +               if (ret2 == -EAGAIN) {
> > +                       restart_count++;
> >                         goto again;
> > +               }
> >                 if (ret2) {
> >                         ret = ret2;
> >                         goto done;
> > @@ -2236,6 +2242,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >                 if (slot == 0 && ins_len && write_lock_level < level + 1) {
> >                         write_lock_level = level + 1;
> >                         btrfs_release_path(p);
> > +                       restart_count++;
> >                         goto again;
> >                 }
> >
> > @@ -2249,8 +2256,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >                 }
> >
> >                 ret2 = read_block_for_search(root, p, &b, slot, key);
> > -               if (ret2 == -EAGAIN && !p->nowait)
> > +               if (ret2 == -EAGAIN && !p->nowait) {
> > +                       restart_count++;
> >                         goto again;
> > +               }
> >                 if (ret2) {
> >                         ret = ret2;
> >                         goto done;
> > @@ -2281,6 +2290,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >         }
> >         ret = 1;
> >  done:
> > +       if (cow_count > 0)
> > +               trace_btrfs_search_slot_stats(root, cow_count, restart_count, ret);
> 
> So I find this way too specific, plus even if trace points are
> disabled we have the overhead of the counters (and inside critical
> sections).
> 
> We already have a tracepoint for COW, trace_btrfs_cow_block(), and we
> could have one just for the retry thing, maybe naming it like
> trace_btrfs_search_slot_restart() or something.
> So we could use those two tracepoints to measure things (bpftrace
> scripts could easily report a count of each trace point and such),
> instead of this highly specialized tracepoint that adds some overhead
> when tracepoints are disabled.

Good point, added a per-restart-site trace_btrfs_search_slot_restart()
tracepoint in v3.

Thanks,
Leo

> 
> Thanks.
> 
> 
> >         if (ret < 0 && !p->skip_release_on_error)
> >                 btrfs_release_path(p);
> >
> > diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> > index 125bdc166bfe..b8934938a087 100644
> > --- a/include/trace/events/btrfs.h
> > +++ b/include/trace/events/btrfs.h
> > @@ -1110,6 +1110,32 @@ TRACE_EVENT(btrfs_cow_block,
> >                   __entry->cow_level)
> >  );
> >
> > +TRACE_EVENT(btrfs_search_slot_stats,
> > +
> > +       TP_PROTO(const struct btrfs_root *root,
> > +                int cow_count, int restart_count, int ret),
> > +
> > +       TP_ARGS(root, cow_count, restart_count, ret),
> > +
> > +       TP_STRUCT__entry_btrfs(
> > +               __field(        u64,    root_objectid           )
> > +               __field(        int,    cow_count               )
> > +               __field(        int,    restart_count           )
> > +               __field(        int,    ret                     )
> > +       ),
> > +
> > +       TP_fast_assign_btrfs(root->fs_info,
> > +               __entry->root_objectid  = btrfs_root_id(root);
> > +               __entry->cow_count      = cow_count;
> > +               __entry->restart_count  = restart_count;
> > +               __entry->ret            = ret;
> > +       ),
> > +
> > +       TP_printk_btrfs("root=%llu(%s) cow_count=%d restarts=%d ret=%d",
> > +                 show_root_type(__entry->root_objectid),
> > +                 __entry->cow_count, __entry->restart_count, __entry->ret)
> > +);
> > +
> >  TRACE_EVENT(btrfs_space_reservation,
> >
> >         TP_PROTO(const struct btrfs_fs_info *fs_info, const char *type, u64 val,
> > --
> > 2.47.3
> >
> >

