Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD04231F2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgG2NWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 09:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2NWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 09:22:44 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392FC0619D2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 06:22:43 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id E7BCC9C360; Wed, 29 Jul 2020 14:22:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1596028959;
        bh=evYjJu5ky82/tT4GZM/6IQb3w4r+8tqJg1L8kxZijy8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FHCld7Z4S/ETvEMZeeTsdIE+ps5n13NUauUoUJhL2n+T0Rwrz6z8Zkk7NIt1PjVzk
         UXlVFLmATjKvfsnnyP5KSjZptY4sPqcoPugwngdhPKgm6v1/sL6CLKnrIla8ORLFfm
         pc1CtXo4o1IxfVSBSIc3FZLCc1GozIMmV47EqKCi0Tz0zm6pf3JOlya1/ZICFjylEh
         dzOsE0v6+JQdQzbjV6GqMhk7w9W4Fc3jxXKARCpKUz3ZLaJa5AIMWn3oKFxsvFXENj
         BeRWgvrkOjSks561zrZwmXKdOLCH6xWqPPYiwvIL+NPvlFWFIKAp7/G79LgVtZG0Ou
         bdbZ5Q3nMcyEg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-1.6 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id C5BAB9BEE9;
        Wed, 29 Jul 2020 14:22:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1596028954;
        bh=evYjJu5ky82/tT4GZM/6IQb3w4r+8tqJg1L8kxZijy8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gHGUOcDBTGPxZNHkeMn+stiOcWqOaDdFEjOIhv5LOQ1nVRFkKy8sIn5NoOrHS1YUA
         +vnMbPM+DLzHWvPvfgO3vUmWYoNa1/7KW6qTwmc8rycWqrVGbNMkT2uSc9qCvG5kUA
         pBhiZ8SIYlfzeURWybpcD90JT4zPj16jfGUtAKjWEldb0ayL1QIuYNd9HBYX0nnZTp
         WeHUwTzvj4RcJmJWPBVThpUOfTvmXrOwKDj/ajijJDjDyr6ex+dFuH8e9Asgg6x6YU
         5io/VrNn4hYmFv9lCyyMyvZni7ap4i0H7aMF8Dl0vlyN9LLIRkp21ftmB8YsllvcDH
         cUh0nYRNSToeQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 3DBDE13DF83;
        Wed, 29 Jul 2020 14:22:34 +0100 (BST)
Subject: Re: using btrfs subvolume as a write once read many medium
To:     spaarder <spaarder@hotmail.nl>
Cc:     linux-btrfs@vger.kernel.org
References: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
 <20200729170323.2fe0b452@natsu>
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
Message-ID: <b81cd527-2cdb-ea58-4731-3ce4dd09a237@cobb.uk.net>
Date:   Wed, 29 Jul 2020 14:22:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200729170323.2fe0b452@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2020 13:03, Roman Mamedov wrote:
> On Wed, 29 Jul 2020 09:02:14 +0200
> spaarder <spaarder@hotmail.nl> wrote:
> 
>> Hello,
>>
>> With all the ransomware attacks I am looking for a "write once read
>> many" (WORM) solution, so that if an attacker manages to get root
>> access on my backup server, it would be impossible for him to
>> delete/encrypt my backups.
> 
> If the attacker gets root on the said server, they could just do
> "dd if=/dev/zero of=/your/btrfs", and no amount of password-protected,
> read-only or sealed subvolumes will save you.
> 
> If you want to be more secure against that, include offline (powered off)
> media into your backup scheme, which is powered-on to synchronize e.g. only
> for short periods of time and under close supervision.

Roman makes excellent points. What I do is a combination of different
types of backups. Basically:

- There are local backup disks on most systems. These have a few local
snapshot-based backups primarily for easy restoration of accidentally
deleted files. These could be easily trashed by any rogue software. In
some cases they also keep some local backups which are only accessible
to root - but they could also be trashed by software which can get local
root access.

- My main backups are created on a separate backup server. That has ssh
key-based access into the user systems (but not the other way around)
and uses btrbk to create backups (with snapshots going back several
years). It doesn't run user applications so compromising it would
require a remote root access hole in the standard debian packages it
uses. Which is unlikely but not impossible.

- My "offsite" backups (mainly to protect against a fire at home, but
useful for ransomware as well) archive backups to cloud services. Again
with archives going back years.

- I also occasionally copy some encrypted backups onto disks I
physically remove and store at friends houses. Fortunately I have never
needed one of these.

It is actually a bit more complicated than that but the bottom line is
that a person, willing to spend time discovering all my backups and
exploiting (currently unknown) remote access bugs could destroy all my
backups except the disks stored at other houses. However, as I am not
worrying about state-level attackers, I am confident that ransomware
software would not be able to do it.

