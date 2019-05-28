Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559382CF6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfE1TZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 15:25:42 -0400
Received: from patury.gsr.inpe.br ([150.163.73.148]:38685 "EHLO
        patury.gsr.inpe.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfE1TZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 15:25:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by patury.gsr.inpe.br (Postfix) with ESMTP id 49E5F120526;
        Tue, 28 May 2019 19:25:39 +0000 (UTC)
Received: from mail1.inpe.br ([127.0.0.1])
 by localhost (mail1.inpe.br [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 27232-04; Tue, 28 May 2019 16:25:38 -0300 (-03)
Received: from [172.16.43.119] (wgateway.gsr.inpe.br [150.163.68.1])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by patury.gsr.inpe.br (Postfix) with ESMTPSA id 388D5120528;
        Tue, 28 May 2019 16:25:38 -0300 (-03)
Subject: Re: Unable to mount, corrupt leaf
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans@knorrie.org>
References: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
 <20190528185403.GE21741@carfax.org.uk>
From:   Cesar Strauss <cesar.strauss@inpe.br>
Openpgp: preference=signencrypt
Autocrypt: addr=cesar.strauss@inpe.br; prefer-encrypt=mutual; keydata=
 mQGiBEVwJ9ERBACxDcBxP8y5Vf6p0CkwwwfwQNx4nNRpDuuS8IwdVwzhrYJe8x5KBZxxIRnf
 FlWS1707czKBptrXSHsCjoS7+PbMYkZg4wKSIZsX2PTwSAM6pzgFU67QAV5z8uVrI6ORL4dR
 NBZYjBFo15NxLGvWwiPv1UtQsLxFiqcWyr9n6w8n0wCgztT3PoP9BvcIT71yzHmFSoPPyLED
 /ifk/yA//X8VkIHj5yffLkSPlHIymeYL9bMTK4paNePUqYoZ1OKv7lFcXbNn3Ug1d3idkLey
 82E580U7BQ+8KIPy+OK4m0X+5jRcim7W7fDyo0Yw+o0dDQtil3mJE38stAbpa6wY4xk/G7TS
 wkb2PyZMGD3Mmn2VS6Q9rO8vhOYTA/9mpS0TilOwo8I9NMFbzFMqhs4bt71QJUBznAQnvE7S
 kcTkamXyfwMo/I+oKjr+xtyKuAvW0Txrtj+BJgC405XPd4z5Tpj5fb+zSVDr0fag291Hhpuq
 xWtiiFPt7Mk5LT2IUBWfJKVZziF79IjCH1Kg2CR9nr40R+x8x1nVunfmQrQlQ2VzYXIgU3Ry
 YXVzcyA8Y2VzYXIuc3RyYXVzc0BpbnBlLmJyPoh6BBMRAgA6AhsjBwsJCAcDAgEGFQgCCQoL
 BBYCAwECHgECF4AWIQQCb1/P7ch/bupd10ne0AVHqalkTAUCW4MIMQAKCRDe0AVHqalkTFyG
 AKCnsX5qc49VLt/29mFYWrF12pKazwCfZkDFAhSjgIzwQX3JA4LPeUfZHlW5Ag0ETH5QGxAI
 ANI1AGfsDelewQpX2TVNYqozq7X1mpBHeaPhb2zQxoto5HPZnMbux/eyg56nqj6bZ7WOioiW
 Kr06DZGyNprXhYZ5f3ee4N/ZnFEPCpfJA3j9g8oHZjbaDIrU6MG4NV0tFbUyNskd0+8Ji34G
 GxXVLQfW3VtuXlxeOF2gqWbIGxeBsn2yypD88yKdffsuyoyH7gwNVIveLTXpTqmQ4ryFvAro
 exiq2u36LzFTJCx+u2XDcLFjxeObFzU8y5YE4NBsDiWoGtxecEovmHjSz7y1CDNdF0FINwLn
 2Sysp9XOqud20q7ppyJ3FM/N45ubmtN8vavX6at4M72gRHx55DFNdV8AAwcIALoOpNfZ0GXN
 TKIsZyfSN3ylGpXNGo8Y7+LP9x9KbkeIhAkqhNubMGtzATvyqzWDzGU+64iGNK11AL+HpwmS
 fJpvcdk/IR8fUJzwEXt0ZZK3X1jTsiF3pK51//2f2VueigEY5E4uHoy8jpPcB6oqmC9yrCeU
 8E/Iu7b7Gj0+bJ0v/1Ksjq22MP3CWqD6ro+E9ErOtMBAZqVzIzCyX6gUWILsQ49uZauWAS7Y
 dIIo4qBUkh27aIb5NxC0E2QdkvFjt0FNR81yVFb1WuVnHq3o91OM0GbuPAJM1wqDmnbq7xtg
 BKPKvWhi0+OPX9KOzMRkDk0iXcDzrnyQ8bjMBn83rs6ISQQYEQIACQUCTH5QGwIbDAAKCRDe
 0AVHqalkTAA+AKCfOfNOi8EObWM2Tj1J9K2umwBT0gCfWWXQOq3GHsEupZqrKu2LJ21xOzo=
Message-ID: <99dd9c01-011f-5969-cfac-967ec0554c3c@inpe.br>
Date:   Tue, 28 May 2019 16:25:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528185403.GE21741@carfax.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Maia Mailguard 1.0.2c
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/28/2019 15:54, Hugo Mills wrote:
> 
>    You have bad RAM.
> 

On 05/28/2019 15:56, Hans van Kranenburg wrote:
> So, what you're observing here is a bitflip. One of the zeros flipped
> into a one, which caused the 14634 to suddenly become 268450090.

Indeed, I had RAM trouble some time ago.

Thank you both for the advice. I'll restore from a backup after I solve
the RAM problem.

Regards,

Cesar
