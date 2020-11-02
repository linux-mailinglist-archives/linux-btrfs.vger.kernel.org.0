Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468362A340B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 20:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKBT3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 14:29:07 -0500
Received: from waffle.tech ([104.225.250.114]:47534 "EHLO mx.waffle.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgKBT3H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 14:29:07 -0500
Received: from mx.waffle.tech (unknown [10.50.1.6])
        by mx.waffle.tech (Postfix) with ESMTP id 345D694410;
        Mon,  2 Nov 2020 12:29:05 -0700 (MST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.waffle.tech 345D694410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waffle.tech; s=mx;
        t=1604345345; bh=XFBjJtnukioeL5UJtcUFhV2fW6hRqwuFlMVY3U1xeOY=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=tOhASUv7r6qHc2ILE11sJxyiSmXspmPEi2c89n8AfbA/215WmfShF1ZXwYmdKDiom
         LU101kBRDrXuE1Jz2TI0k4+VQCXz455LIBkvULm6qafw/6hb64qmI7+emHnuEDmJFd
         HP4mJ2BKAurv6P9PAzdYj7E+Q83nfFP6ZbgDz95w=
Received: from waffle.tech ([10.50.1.3])
        by mx.waffle.tech with ESMTPSA
        id X0mECwFeoF+RDgkAQqPLoA
        (envelope-from <louis@waffle.tech>); Mon, 02 Nov 2020 12:29:05 -0700
MIME-Version: 1.0
Date:   Mon, 02 Nov 2020 19:29:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From:   louis@waffle.tech
Message-ID: <041d24ef26dc5c763c5af6d6de7434ef@waffle.tech>
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     "Nikolay Borisov" <nborisov@suse.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <d4d600aa-a56b-2458-f504-afbb584f888b@suse.com>
References: <d4d600aa-a56b-2458-f504-afbb584f888b@suse.com>
 <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
 <20201023153814.643F.409509F4@e16-tech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.waffle.tech
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good points. I'll move it into 'struct btrfs_fs_info', look at making it =
a per-cpu variable, and do some testing with perf (later this week hopefu=
lly).=0A=0ALouis=0A=0AOctober 23, 2020 1:42 AM, "Nikolay Borisov" <nboris=
ov@suse.com> wrote:=0A=0A> On 23.10.20 =D0=B3. 10:38 =D1=87., Wang Yugui =
wrote:=0A> =0A>> Hi, Louis Jencka=0A>> =0A>> Can we move 'atomic_t rr_cou=
nter' into 'struct btrfs_fs_info' to=0A>> support multiple mounted btrfs =
filesystem?=0A> =0A> And introduce constant cache line pings for every re=
ad. This thing needs=0A> to be tested under load with perf to see what ki=
nd of overhead the=0A> shared atomic_t counter adds. My hunch is this sho=
uld really be a=0A> per-cpu variable.=0A> =0A> <snip>
