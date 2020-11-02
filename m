Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956AC2A3440
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKBTgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 14:36:48 -0500
Received: from waffle.tech ([104.225.250.114]:48712 "EHLO mx.waffle.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKBTgs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 14:36:48 -0500
Received: from mx.waffle.tech (unknown [10.50.1.6])
        by mx.waffle.tech (Postfix) with ESMTP id B5A447FBBC
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Nov 2020 12:36:47 -0700 (MST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.waffle.tech B5A447FBBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waffle.tech; s=mx;
        t=1604345807; bh=nD00R5zrMIr3ysqVMB5qw73eFVa7NDW1Ief7BPkNNNc=;
        h=Date:From:Subject:Cc:In-Reply-To:References:From;
        b=FJnlwHpFTK4yCbZv+/T0AKZMT2fQeT4w5NWjnAQwM4H+rk2FKcs6qpJiEqWxCRvGH
         ErPIrHERsNWrNmlTf+fLZrewSCCaa/LjJJtd6dNQVmYP9ZsuA98v2XAw6Kgi1RlwZo
         BDFAd086oM210mBCx/j+QhgA4pF4r3P7hjfWvDgs=
Received: from waffle.tech ([10.50.1.3])
        by mx.waffle.tech with ESMTPSA
        id DWctLM9foF+WEAkAQqPLoA
        (envelope-from <louis@waffle.tech>)
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Nov 2020 12:36:47 -0700
MIME-Version: 1.0
Date:   Mon, 02 Nov 2020 19:36:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From:   louis@waffle.tech
Message-ID: <6be7aac97435165d11c38b365db19f6f@waffle.tech>
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <041d24ef26dc5c763c5af6d6de7434ef@waffle.tech>
References: <041d24ef26dc5c763c5af6d6de7434ef@waffle.tech>
 <d4d600aa-a56b-2458-f504-afbb584f888b@suse.com>
 <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
 <20201023153814.643F.409509F4@e16-tech.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx.waffle.tech
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ha nevermind, looks like Anand Jain beat me to the punch.=0A=0ALouis=0A=
=0ANovember 2, 2020 12:29 PM, louis@waffle.tech wrote:=0A=0A> Good points=
. I'll move it into 'struct btrfs_fs_info', look at making it a per-cpu v=
ariable, and do=0A> some testing with perf (later this week hopefully).=
=0A> =0A> Louis=0A> =0A> October 23, 2020 1:42 AM, "Nikolay Borisov" <nbo=
risov@suse.com> wrote:=0A> =0A>> On 23.10.20 =D0=B3. 10:38 =D1=87., Wang =
Yugui wrote:=0A>> =0A>>> Hi, Louis Jencka=0A>>> =0A>>> Can we move 'atomi=
c_t rr_counter' into 'struct btrfs_fs_info' to=0A>>> support multiple mou=
nted btrfs filesystem?=0A>> =0A>> And introduce constant cache line pings=
 for every read. This thing needs=0A>> to be tested under load with perf =
to see what kind of overhead the=0A>> shared atomic_t counter adds. My hu=
nch is this should really be a=0A>> per-cpu variable.=0A>> =0A>> <snip>
