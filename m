Return-Path: <linux-btrfs+bounces-4577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67048B4BDA
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA35F1C20E0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC96BB37;
	Sun, 28 Apr 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBMV4B/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA66A8DB
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308863; cv=none; b=XOSQFcdfk7S7hRae8CyiPtYmRBjNbUEm+yUGGxpwPdl49qSAYK20UKM61nMf7SZT8/pG8CBtjIyfcdZGuHghTNQtwOrLm26iYDaAiOKupt+NdGXNXTnP4lmWvbERHikWUsTT3gWkKDcHkB/pAzvi1iuuRriO3VYOTD6IhfMm1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308863; c=relaxed/simple;
	bh=e4GvHByfVPKZdNWa6lawORkUi/dUpn/3m19pmLdcUcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=imb5Wsx8Dp6hu1BSZShnF81+4iEpsMM36KZO2SANS6yv6TsZblh8aRlRl8APM+jTq64Cg53PZmAyBO0P6dpibZeC0p4YyvLMpKmoX8d0VDLBIhA79tJkPRyByBWIATxp1c5Zk0uBGdRgTyQvanB6mhARjZJlx6nVdhXkpKSPMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBMV4B/I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724e69780bso3414385a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714308859; x=1714913659; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWIqWAXvOZGUUEyaPl4m9BaL9TTohCeBv7pV6UpiPvA=;
        b=fBMV4B/IGDqXhnvGLCBMKBd9NOTYvK9I2wP1fJpRT13zY3+zSgkIwa7hVp1MxrAFSu
         ufBXRyq5XeMN3t9ZkWi/gZO/3mYuO/ORyIMPtBqaxRlbGiArIa5NiBo6rDy3QEKlHQCn
         WJX/ITl+0zd9p90PauO4U5TiPxEuICpLQLfa90lQV5h4N6wQXy15rgRrQCc2eii1rJTx
         pjlAp7TdNqK0831ZSOiLkPpqZEPeCxUlED5+FJRKlvkWHZt9sPILZGWlVdnh5ZXwRGFP
         PLO+APTCZcwe3gzR0HKOpjBsbFkQa7Ipco4alk/YvrjCbqkPRlmRjpq/BibYVPSzhPtF
         ML8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714308859; x=1714913659;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWIqWAXvOZGUUEyaPl4m9BaL9TTohCeBv7pV6UpiPvA=;
        b=OrPMga0MDei9KWgwVDsumEMyunjeUkUi9KDtxJybALxEKRNa/6jdLT317VcMnNK8rh
         LK2TS2ufxsnLrn7xd/Urj+xJ/fsNppuT1lU6G3NHd7JpUDSYqRAKKOm4qA7VSsSYXpr9
         edz8SUTyCCgs2vV0LCWT0J6U2+2oeejgqIrqauaGgGtwPDZBXlLldUpXQ/Xite4wJaFE
         HAp4JmkAXuBGXTsgsTi1Vaj5lxWW0u0JsEvLVo5aSSblw0uGOO5S4LIq5ckLxlLPvYvn
         98G58WjQ2fxaVm5nwT3TWrHzjo8qpsG7zImTmbvyI9gxIeeBUif/M27bcc98Ku2gppf/
         yuag==
X-Gm-Message-State: AOJu0YzgzOKKkWXfHM+TBxpPPwAC/4NCqArd+0QJ3g9Zf5mjOM4dPkug
	EHauMNpRtYvnRMukeStwV73eGch2K7QuMNNhbUKs3DRVt1WPEcu6cVaspbJapzc=
X-Google-Smtp-Source: AGHT+IHM8FhZ0K2RCjed/Hqiziz9BQeC9/HyFlaQJuM/NlIcgxe6FPoJ4kxdgbjZVfClbWfIirdT+g==
X-Received: by 2002:a50:f61e:0:b0:56e:2a7d:827c with SMTP id c30-20020a50f61e000000b0056e2a7d827cmr5537931edn.18.1714308859064;
        Sun, 28 Apr 2024 05:54:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0056e2432d10bsm12056743edb.70.2024.04.28.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 05:54:18 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:54:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: josef@toxicpanda.com
Cc: linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: clean up our handling of refs == 0 in snapshot
 delete
Message-ID: <96789032-42fb-41c0-b16c-561ac00ca7c3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Josef Bacik,

Commit a07155f4e6b8 ("btrfs: clean up our handling of refs == 0 in
snapshot delete") from Apr 19, 2024 (linux-next), leads to the
following Smatch static checker warning:

	fs/btrfs/extent-tree.c:5875 walk_up_proc()
	warn: inconsistent returns '&eb->lock'.

fs/btrfs/extent-tree.c
    5766 static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
    5767                                  struct btrfs_root *root,
    5768                                  struct btrfs_path *path,
    5769                                  struct walk_control *wc)
    5770 {
    5771         struct btrfs_fs_info *fs_info = root->fs_info;
    5772         int ret;
    5773         int level = wc->level;
    5774         struct extent_buffer *eb = path->nodes[level];
    5775         u64 parent = 0;
    5776 
    5777         if (wc->stage == UPDATE_BACKREF) {
    5778                 ASSERT(wc->shared_level >= level);
    5779                 if (level < wc->shared_level)
    5780                         goto out;
    5781 
    5782                 ret = find_next_key(path, level + 1, &wc->update_progress);
    5783                 if (ret > 0)
    5784                         wc->update_ref = 0;
    5785 
    5786                 wc->stage = DROP_REFERENCE;
    5787                 wc->shared_level = -1;
    5788                 path->slots[level] = 0;
    5789 
    5790                 /*
    5791                  * check reference count again if the block isn't locked.
    5792                  * we should start walking down the tree again if reference
    5793                  * count is one.
    5794                  */
    5795                 if (!path->locks[level]) {
    5796                         ASSERT(level > 0);
    5797                         btrfs_tree_lock(eb);
                                 ^^^^^^^^^^^^^^^^^^^^
Takes the lock

    5798                         path->locks[level] = BTRFS_WRITE_LOCK;
    5799 
    5800                         ret = btrfs_lookup_extent_info(trans, fs_info,
    5801                                                        eb->start, level, 1,
    5802                                                        &wc->refs[level],
    5803                                                        &wc->flags[level],
    5804                                                        NULL);
    5805                         if (ret < 0) {
    5806                                 btrfs_tree_unlock_rw(eb, path->locks[level]);

These paths drop the lock

    5807                                 path->locks[level] = 0;
    5808                                 return ret;
    5809                         }
    5810                         if (unlikely(wc->refs[level] == 0)) {
    5811                                 btrfs_err(fs_info, "Missing refs.");
    5812                                 return -EUCLEAN;

But this new return doesn't.

    5813                         }
    5814                         if (wc->refs[level] == 1) {
    5815                                 btrfs_tree_unlock_rw(eb, path->locks[level]);
    5816                                 path->locks[level] = 0;
    5817                                 return 1;
    5818                         }
    5819                 }
    5820         }
    5821 
    5822         /* wc->stage == DROP_REFERENCE */

regards,
dan carpenter

