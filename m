Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0B364210
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhDSMws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 08:52:48 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:43748 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhDSMws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 08:52:48 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 349606C0071F;
        Mon, 19 Apr 2021 15:52:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1618836737; bh=IDrw7leacTEIwXTETcPBpm59t8J0vO4DMTULHsxmMyU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=lf0gm+sp+/qq1DANWlg4jyYfs/oenLpK14k3gf5mMLY27X1FFr/Aivsa363ksZxdw
         bpbPmoYLJF7dIiIKsJZnUR1M1Fy2A0xw2Dtg74IGcxxqBOPLazedDhIYWQOqlEtivL
         18AiqwMD2/ZwCHVDSaoKiYt8KcYedOpLKKaTwMww=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 2519F6C006D2;
        Mon, 19 Apr 2021 15:52:17 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id TwP7tsddMWlJ; Mon, 19 Apr 2021 15:52:16 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 940D16C00700;
        Mon, 19 Apr 2021 15:52:16 +0300 (EEST)
Received: from nas (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 9E5DE1BE00E8;
        Mon, 19 Apr 2021 15:52:14 +0300 (EEST)
References: <20210419124541.148269-1-l@damenly.su>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs-progs: fi resize: fix false 0.00B sized output
Date:   Mon, 19 Apr 2021 20:49:45 +0800
In-reply-to: <20210419124541.148269-1-l@damenly.su>
Message-ID: <blaaa140.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgs0s1k6UZeF557a3RlcgnP9LyeBYEsOTGPJkCwpDWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 19 Apr 2021 at 20:45, Su Yue <l@damenly.su> wrote:

> Resize to nums without sign prefix makes false output:
> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
>
> The resize operation would take effect though.
>
> Fix it by handling the case if mod is 0 in check_resize_args().
>
> Issue: #307
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Su Yue <l@damenly.su>
> ---
>  cmds/filesystem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 9e3cce687d6e..607c85a0bccc 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1158,6 +1158,13 @@ static int check_resize_args(const char 
> *amount, const char *path) {
>  		}
>  		old_size = di_args[dev_idx].total_bytes;
>
> +		/* For target sizes without '+'/'-' sign prefix(e.g. 
> 1:150g) */
> +		if (mod == 0) {
> +			new_size = diff;
> +			diff = new_size - old_size;
>

> +			mod = diff;
>
Hmmm.. diff is a u64... will send v2.
> +		}
> +
>  		if (mod < 0) {
>  			if (diff > old_size) {
>  				error("current size is %s which is smaller than 
>  %s",

