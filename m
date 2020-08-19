Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2562D249D26
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 14:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHSMCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgHSL7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:46 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C0C061383
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 04:59:46 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id A94759C3B8; Wed, 19 Aug 2020 12:59:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1597838380;
        bh=CH6YnVKfstZkLvjgNmasPJb0j9QVuAw9xV2ghcXqIks=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZI+Ao5s1SyCrzbnRANfFOKw70sU5Jwjxojfm6XkEBR98qbz5RWyp6Ha8LUEulWw4v
         fNV84KojLV3dHd/SyBknxb8OayzRtqktC1f2sr9UldXxqGPLxvs03MisIOWqJILpOM
         E2UDZRpKwUkliWx10Y6Lq3eRzvz9RdnAynL2MBDYj+BHbSpoivEh+1G8saB/ZZ47GB
         1t7kKZQOUHM4NuHy9qb3LacdtacGMZ4+RVd/g7aSqq7WPyJFFPvOZ8j8iSGT+7JFBI
         vf6GX/Uj3NFD381WTHQmEjDP6+ftz/GhW9IRJP0uO50z6svMC1weYfpI9tuAwkKMQ2
         2vzqBz+PkayWQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-2.2 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id E75F79B7D0;
        Wed, 19 Aug 2020 12:59:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1597838370;
        bh=CH6YnVKfstZkLvjgNmasPJb0j9QVuAw9xV2ghcXqIks=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Qd5Yt9qFeTMWmW9HTIMXgtfT852bOrQUVzMlKwcA7JfDCVj7P+lcFSxQsVN0RxqsY
         hkyrp9TkSxtmv4UWONkVZI3l1NPGCxJn9be/eGxZGFXwe8tJXi6oPWZIkpVVCDWYnp
         7/yTvDj3hnAOD3Hf0ObX5ncvTIjoyQcAcGr5j0sUde6DewEF+ilSYIMjLmCyoLudHF
         3hQB4+LFesVKZmZXfJBWgz6sMJv1SNUQ4cb3F6JSeAtt3g2Qh0/4UnQZx1pWnwpb4D
         AJcgOglYj1D2mXqAoAdIwNWb6B647InscZyh+1/pm2k0DEi8Hk0cs10G49L9JJLmu6
         HYJsb3g6EOyoA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 3F64714F14A;
        Wed, 19 Aug 2020 12:59:29 +0100 (BST)
Subject: Re: [PATCH] btrfs: detect nocow for swap after snapshot delete
To:     dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200818180005.933061-1-boris@bur.io>
 <20200819112941.GK2026@twin.jikos.cz>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 mQINBFaetnIBEAC5cHHbXztbmZhxDof6rYh/Dd5otxJXZ1p7cjE2GN9hCH7gQDOq5EJNqF9c
 VtD9rIywYT1i3qpHWyWo0BIwkWvr1TyFd3CioBe7qfo/8QoeA9nnXVZL2gcorI85a2GVRepb
 kbE22X059P1Z1Cy7c29dc8uDEzAucCILyfrNdZ/9jOTDN9wyyHo4GgPnf9lW3bKqF+t//TSh
 SOOis2+xt60y2In/ls29tD3G2ANcyoKF98JYsTypKJJiX07rK3yKTQbfqvKlc1CPWOuXE2x8
 DdI3wiWlKKeOswdA2JFHJnkRjfrX9AKQm9Nk5JcX47rLxnWMEwlBJbu5NKIW5CUs/5UYqs5s
 0c6UZ3lVwinFVDPC/RO8ixVwDBa+HspoSDz1nJyaRvTv6FBQeiMISeF/iRKnjSJGlx3AzyET
 ZP8bbLnSOiUbXP8q69i2epnhuap7jCcO38HA6qr+GSc7rpl042mZw2k0bojfv6o0DBsS/AWC
 DPFExfDI63On6lUKgf6E9vD3hvr+y7FfWdYWxauonYI8/i86KdWB8yaYMTNWM/+FAKfbKRCP
 dMOMnw7bTbUJMxN51GknnutQlB3aDTz4ze/OUAsAOvXEdlDYAj6JqFNdZW3k9v/QuQifTslR
 JkqVal4+I1SUxj8OJwQWOv/cAjCKJLr5g6UfUIH6rKVAWjEx+wARAQABtDNHcmFoYW0gQ29i
 YiAoUGVyc29uYWwgYWRkcmVzcykgPGdyYWhhbUBjb2JiLnVrLm5ldD6JAlEEEwECADsCGwEG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJWnr9UFRhoa3A6Ly9rZXlzLmdudXBnLm5l
 dAAKCRBv35GGXfm3Tte8D/45+/dnVdvzPsKgnrdoXpmvhImGaSctn9bhAKvng7EkrQjgV3cf
 C9GMgK0vEJu+4f/sqWA7hPKUq/jW5vRETcvqEp7v7z+56kqq5LUQE5+slsEb/A4lMP4ppwd+
 TPwwDrtVlKNqbKJOM0kPkpj7GRy3xeOYh9D7DtFj2vlmaAy6XvKav/UUU4PoUdeCRyZCRfl0
 Wi8pQBh0ngQWfW/VqI7VsG3Qov5Xt7cTzLuP/PhvzM2c5ltZzEzvz7S/jbB1+pnV9P7WLMYd
 EjhCYzJweCgXyQHCaAWGiHvBOpmxjbHXwX/6xTOJA5CGecDeIDjiK3le7ubFwQAfCgnmnzEj
 pDG+3wq7co7SbtGLVM3hBsYs27M04Oi2aIDUN1RSb0vsB6c07ECT52cggIZSOCvntl6n+uMl
 p0WDrl1i0mJUbztQtDzGxM7nw+4pJPV4iX1jJYbWutBwvC+7F1n2F6Niu/Y3ew9a3ixV2+T6
 aHWkw7/VQvXGnLHfcFbIbzNoAvI6RNnuEqoCnZHxplEr7LuxLR41Z/XAuCkvK41N/SOI9zzT
 GLgUyQVOksdbPaxTgBfah9QlC9eXOKYdw826rGXQsvG7h67nqi67bp1I5dMgbM/+2quY9xk0
 hkWSBKFP7bXYu4kjXZUaYsoRFEfL0gB53eF21777/rR87dEhptCnaoXeqbkBDQRWnrnDAQgA
 0fRG36Ul3Y+iFs82JPBHDpFJjS/wDK+1j7WIoy0nYAiciAtfpXB6hV+fWurdjmXM4Jr8x73S
 xHzmf9yhZSTn3nc5GaK/jjwy3eUdoXu9jQnBIIY68VbgGaPdtD600QtfWt2zf2JC+3CMIwQ2
 fK6joG43sM1nXiaBBHrr0IadSlas1zbinfMGVYAd3efUxlIUPpUK+B1JA12ZCD2PCTdTmVDe
 DPEsYZKuwC8KJt60MjK9zITqKsf21StwFe9Ak1lqX2DmJI4F12FQvS/E3UGdrAFAj+3HGibR
 yfzoT+w9UN2tHm/txFlPuhGU/LosXYCxisgNnF/R4zqkTC1/ao7/PQARAQABiQIlBBgBAgAP
 BQJWnrnDAhsMBQkJZgGAAAoJEG/fkYZd+bdO9b4P/0y3ADmZkbtme4+Bdp68uisDzfI4c/qo
 XSLTxY122QRVNXxn51yRRTzykHtv7/Zd/dUD5zvwj2xXBt9wk4V060wtqh3lD6DE5mQkCVar
 eAfHoygGMG+/mJDUIZD56m5aXN5Xiq77SwTeqJnzc/lYAyZXnTAWfAecVSdLQcKH21p/0AxW
 GU9+IpIjt8XUEGThPNsCOcdemC5u0I1ZeVRXAysBj2ymH0L3EW9B6a0airCmJ3Yctm0maqy+
 2MQ0Q6Jw8DWXbwynmnmzLlLEaN8wwAPo5cb3vcNM3BTcWMaEUHRlg82VR2O+RYpbXAuPOkNo
 6K8mxta3BoZt3zYGwtqc/cpVIHpky+e38/5yEXxzBNn8Rn1xD6pHszYylRP4PfolcgMgi0Ny
 72g40029WqQ6B7bogswoiJ0h3XTX7ipMtuVIVlf+K7r6ca/pX2R9B/fWNSFqaP4v0qBpyJdJ
 LO/FP87yHpEDbbKQKW6Guf6/TKJ7iaG3DDpE7CNCNLfFG/skhrh5Ut4zrG9SjA+0oDkfZ4dI
 B8+QpH3mP9PxkydnxGiGQxvLxI5Q+vQa+1qA5TcCM9SlVLVGelR2+Wj2In+t2GgigTV3PJS4
 tMlN++mrgpjfq4DMYv1AzIBi6/bSR6QGKPYYOOjbk+8Sfao0fmjQeOhj1tAHZuI4hoQbowR+ myxb
Message-ID: <563ca3a3-d07c-cf1f-cb0f-f41f50f8d516@cobb.uk.net>
Date:   Wed, 19 Aug 2020 12:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200819112941.GK2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/08/2020 12:29, David Sterba wrote:
> How often could the snapshot deletion and swapfile activation happen at
> the same time? Snapshotting subvolume with the swapfile requires
> deactivation, snapshot/send/whatever and then activation. This sounds
> like a realistic usecase.

It is very likely when the swapfile is one that is only used
occasionally (for example, when running a particular program which needs
a massive amount of virtual memory, or having to stop using a different
swapfile because a disk looks like it is starting to fail).

If the swapfile is not normally used, it is not unlikely it got
snapshotted (as part of a larger operation, presumably) while
deactivated. When the user tries to use it, they realise it isn't
working because it is snapshotted, so they delete the snapshot and then
immediately try to activate it again -- causing confusion when it still
fails.
