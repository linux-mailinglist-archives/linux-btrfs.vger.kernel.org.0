Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0479133420C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCJPtx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 10:49:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:40903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233219AbhCJPtu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 10:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615391386;
        bh=ZzdMmf+FiG0tuW1cYPeA1IiGVvj+9S5ks2FxMhymNpo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Fp5sRIYsYQglDnGepvStLjI0kCkF/pFo+kbPxaaJE0qykmFDvmWfAb2fBQCAs3Tyv
         pEwaYAiaiVZL6wvcirF9O8rP+pr6ZoOk296yWNoiJ4MKyXob0LB7FH00XsOAITbhQ/
         klbihPWlzJCKzhqNiDdS5C9lUh4zUkOczlnerrYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [77.11.30.192] ([77.11.30.192]) by web-mail.gmx.net
 (3c-app-gmx-bs58.server.lan [172.19.170.142]) (via HTTP); Wed, 10 Mar 2021
 16:49:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-a0ab6866-d05a-4626-8bb3-833e89b6d5cf-1615391386529@3c-app-gmx-bs58>
From:   telsch <telsch@gmx.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Aw: Re: no memory is freed after snapshots are deleted
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 Mar 2021 16:49:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <3f1ef2ea-04db-479d-d1cd-f64892de6ef1@cobb.uk.net>
References: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
 <3f1ef2ea-04db-479d-d1cd-f64892de6ef1@cobb.uk.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PeDmEqKrF3l4p380crgYFhsH/BUGUhPA+zjoeCm1BG2lZcbINrjlVB6xBCxlm7G1HuO3I
 0QFqLQJ6dvTkVydEqpUSl2+T7BsyNfuHo7RTe61qqGSy6qLTM3k2aSLo8m0IrPNQlzVX9ZDL7+jh
 DkhXTf7YOam+MrjBbU4mehM+nfMvHAbGrWp1Me1/feI+HHlUwcFcjBgzPc5zxBo2SoQs9lK0jCyF
 UeTIt38uJt4foAGP/79zm0SVPEtpu37ql2pGS8OWmylwnj7pQASF4tvy3BZW+hYtDrM+65AyXYgj
 Lw=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5LjY3BwcKo=:PVk2Kv1ABZNZBENXtHuPYt
 jOrdHsqEkDJMZjWg0+U9yEm3ZAVqAPcq6B8HfEwCTI03VwpeQA2H/xXq8yDb15Mt8tJvBEz2G
 RUy46M4BBg3WBx2SiUFOh2mrumjvXKVsdpJ9iNEWuweOIZBgyEY3Da477p9dab28+3PCj5gxq
 FLW37sK06PxuN2YnXCm0z4HTrcqD+esJ7U7q94ch8qT8SYP5Sxq4Q9XX44vfJVyNpvswL8d37
 aKL9b7TXKBww+iRJ5Dc485wfs+7VEhSWGu4LFWSLFDS+UkGXB67Ntta3cT6jB6Rdtvcvxr65R
 39PK00jhaaYS1FezPeed5ttiAuw+jq7eJffdW2CchscDNktzUqZxHmWhmWNcJgBKa1Nbs5wMP
 SYU3n2RTFE/cU+GPHQpn0X/ogeUvRNVJPBuYjehrkPdAWJyVk8f7jaHOrtVyeWoijHpMddXdK
 AIQZ3LMHhAsTZ1SKBv6+xQarNwHOiYV/5RYbDjDfEn9KbLHGlOm75AxVgU1HGanXgj7PcANxo
 f3Oz8k197frrHMD5bKeYhCb6LsPZNT71Y4i93OLuJppOW8ar0173VTUXCXeyEJ4dA80eI4mls
 jtUGfiW4iOOpw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Don't forget that, in general, deleting a snapshot does nothing - if the
> original files are still there (or any other snapshots of the same files
> are still there). In my experience, if you *really* need space urgently
> you are best of starting with deleting some big files *and* all the
> snapshots containing them, rather than starting by deleting snapshots.
>
> If you are doing balances with low space, I find it useful to watch
> dmesg to see if the balance is hitting problems finding space to even
> free things up.
>
> However, one big advantage of btrfs is that you can easily temporarily
> add a small amount of space while you sort things out. Just plug in a
> USB memory stick, and add it to the filesystem using 'btrfs device add'.
>
> I don't recommend leaving it as part of the filesystem for long - it is
> too easy for the memory stick to fail, or for you remove it forgetting
> how important it is, but it can be useful when you are trying to do
> things like remove snapshots and files or run balance. Don't forget to
> use btrfs device remove to remove it - not just unplugging it!

Yes that's why i deleted all snapshots.
I had also added a ramdisk to work around the low memory problem during ba=
lance but without success.

Any other ideas to fix this?
