Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7A160EF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 10:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgBQJj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 04:39:57 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:47160 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgBQJj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 04:39:56 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id E8E539C3AE; Mon, 17 Feb 2020 09:39:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581932393;
        bh=V89hxnnmqlCq9BfL86lmrs30gAVnPqRzfgBbLttUUKE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=uUZDNHTWFDdQHzwwXFU7g1xiMxms2++xerbPiqXN3cuqOj7SDHI6avwYWjYfjYLUE
         atnSL0LnE0QT23rr40kI8AlNKJ7vPqxHearHVnXOnzliJ3wRWYc8mRXrPO8/2xZiCP
         Pj6JN3wgIGv7jFFH5Wpbe3144EuLSqKC/6m30f28lyfgnWGlFFNjrHsU6IFDqzrZgc
         vdSOHzfbMGWdMhaSzvmJxS4h5irmf9EI8hdu/aIUyKB8/Zq0VxXpk+U8OjI1aCoEk2
         N5S15DI93tuJeUSFFZHKzDzPIeICVy7cr0p4nHUxbBDLUqoYHyWOdimz0muuxVsM5E
         v83WDnMf1ZkXA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 05C839B9B1;
        Mon, 17 Feb 2020 09:39:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581932389;
        bh=V89hxnnmqlCq9BfL86lmrs30gAVnPqRzfgBbLttUUKE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=wvj2kzL69SVMIZKfz6DiqXJrvZL9xjXSTAtzbxZ/wz/SM22qkyfqXkpbfP+GTxrhp
         ik0BjorNUtvrQ4I/kwMowVbHHBg8dAjnaC57uulKhgt+/9Qt5C9zoxGTd7UCgIUu1M
         TaRn3AoqJMJfuJsNyoZ5kLmI4YSZhu6pQsXxcqQ5RXZivTG12q75/9S/gh0OXysu32
         ME5wQbEk3GjIEEBlNII6/JbqmWmDefrLYRIFw6zDFMECsW/7YRXahcAPyhC+dl1cW/
         6q2RJA57mA6pwsGGNzHmy/IT0cxvDM8nIA55foZjPz9I71Pn9h15i+CXki0zV/4cT7
         6oCkLz8PXl2rQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 73537C604C;
        Mon, 17 Feb 2020 09:39:48 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] btrfs: Make balance cancelling response faster
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200217061654.65567-1-wqu@suse.com>
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
Message-ID: <d4161c6c-7629-3d64-fdf9-51a8841b193b@cobb.uk.net>
Date:   Mon, 17 Feb 2020 09:39:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217061654.65567-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/02/2020 06:16, Qu Wenruo wrote:
...
> [FIX]
> This patchset will add more cancelling check points, to make cancelling
> faster.

I have a question on what this means for users of the balance ioctl.

I *think* that, today, there is a guarantee that if I issue the ioctl to
start a balance, and then immediately (or, some time later) cancel it, I
will be guaranteed that at least one block group will be balanced. In
particular, if I repeat that behaviour, the balance will eventually
complete.

Is that true?

If so, what happens to this guarantee with these changes?

I think, from your description, that the cancel can complete without
even one block group being balanced. Is it guaranteed to have made
progress on that bg so that if I repeat the behaviour that bg (and
eventually all eligible bgs) will be balanced? Or is it now possible to
cancel before any progress has been made sp that process never finishes?

If the latter, how long do I have to wait before cancelling to make sure
that progress has been made? Is there any way to know whether progress
has been made when the ioctl completes with the cancelled status?

This is a real question because I have some filesystems where balancing
a single block group can sometimes take tens of minutes, and the system
is impacted during that time. I already have my btrfs-balance-slowly
script which allows me to control impact by not trying to balance the
next bg for a while, so the system can recover and progress other tasks.
And it would be great to be able to limit the impact further by
cancelling during a single bg, but only if I can be sure that progress
has been made and that by repeating the process I am guaranteed that it
will eventually finish.

In any case, I suggest that the patch cover letter (and maybe code
comments) explains what guarantees (if any) userspace is given.

Graham
