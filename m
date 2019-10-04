Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D903CCB708
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJDJIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:08:47 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:60520 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDJIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 05:08:47 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id CAF4A9C4F8; Fri,  4 Oct 2019 10:08:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1570180124;
        bh=wSdXlu5JnZVFQD/kOVDFMd6Nb0xof+ydAVmNbptjYrE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ocCpivb9fttamuPedOp+qZqt1XFQfe7aoDybHT/ThXx6B5Ssjcb2lSTsAh8XMXp5l
         XUzkB3FtW08a94eJYL39BTelVIp8uvPcIbWXC/XRJnzAJxZMhwSeWoylCr1uMzurCb
         U9yYI6lJ+7UfFip6tm7XddZ/A1YpMCwywC38eY/ZC/WVeD27I7RbBApL5mljponbT3
         1qlbTuziE9huPZFUCJfWXpho4J8PexDxOK+s3m283e5Q7SBnNwj0/SVxU1lQvVNc0+
         AewkkGPWguoTdwZnMBB5v4frXqenaNy1ZYIzHjLjWAk7KGTqIkpHqiFdOEdxgldV4H
         mmN/kDKCQdfWQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DB6F79C4F3;
        Fri,  4 Oct 2019 10:08:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1570180123;
        bh=wSdXlu5JnZVFQD/kOVDFMd6Nb0xof+ydAVmNbptjYrE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZS1Dkx6f4qklTjOfx8pnmFwohUHKPJU+EpoSO+sHkCTb7rKgFGLGeJ7N3Hw+4JJ8l
         h4hnoc7C9td0TJgJfvT1v8Tcv91vqiHvve91dt5NXVM78v300HG9kEMlIOpr3crhpz
         6DnB/gPi+hw2bBf0QaD+Kq8ajeAA8WAEJYBZRXaf15ovBM9vojTMMujJe85P3TjOz9
         abtPvB3m/HCOoW4axJaXpScJoz15DYI6Z2tp2i2FIDIZc+MepApnirELVzkf1Idqwb
         kY8C/rYpoFWyBIXx9PF1ipV4grvYjKQZiTI2/q1/nPRcKX7/7WuPftWdjUG+wcBEJn
         5QH2B3MsPTZiw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A82D455A0C;
        Fri,  4 Oct 2019 10:08:42 +0100 (BST)
Subject: Re: [Not TLS] Re: [PATCH 3/4] btrfs: include non-missing as a
 qualifier for the latest_bdev
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
 <1570175403-4073-4-git-send-email-anand.jain@oracle.com>
 <93c711f8-dc77-dcc2-52b0-fc46487ff16e@suse.com>
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
Message-ID: <8f0fd5a3-c389-b39a-6f22-a17e25cff481@cobb.uk.net>
Date:   Fri, 4 Oct 2019 10:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <93c711f8-dc77-dcc2-52b0-fc46487ff16e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/10/2019 09:11, Nikolay Borisov wrote:
> 
> 
> On 4.10.19 г. 10:50 ч., Anand Jain wrote:
>> btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
>> to point to the bdev with greatest device::generation number.
>> For a typical-missing device the generation number is zero so
>> fs_devices::latest_bdev will never point to it.
>>
>> But if the missing device is due to alienating [1], then
>> device::generation is not-zero and if it is >= to rest of
>> device::generation in the list, then fs_devices::latest_bdev
>> ends up pointing to the missing device and reports the error
>> like this [2]
>>
>> [1]
>> mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
>> sleep 3 # avoid racing with udev's useless scans if needed
>> btrfs dev add -f /dev/sdb /btrfs
> 
> Hm, here I think the correct way is to refuse adding /dev/sdb to an
> existing fs if it's detected to be part of a different one. I.e it
> should require wipefs to be done.

I disagree. -f means "force overwrite of existing filesystem on the
given disk(s)". It shouldn't be any different whether the existing fs is
btrfs or something else.

Graham
