Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801671CBF17
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEIIcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 04:32:23 -0400
Received: from mout.web.de ([212.227.17.11]:36153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIIcX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 04:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589013131;
        bh=sQBpSKjKuyTU/EBNrYGZDgEmBkXLhOAHtku+pj0xBZs=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=PgMfvRq4YxYlI/JbeVHwmny8ZOyC6vt3d9hS3M8t2NxwPPO8ZCBhceRugdzTobK3A
         HBHWS1fGH0Ct9MRS6n7rF9QLBZKNTiViE/a6ssnoPvntQhDlqrNn223wXSBCPDk92z
         KCZoZnMF0dxuB6Ml/hIRuH380VgPRgbMioiTyHmE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.78]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUF4Q-1jfTrt34IE-00QxhE; Sat, 09
 May 2020 10:32:11 +0200
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/4] fs: btrfs: fix a data race in
 btrfs_block_group_done()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <4db5bc60-5df4-9e49-4a76-a611d492af56@web.de>
Date:   Sat, 9 May 2020 10:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:g1PTlr4vRtPBR1Tw2jv9N4XzB984f4Q71qy9z4kNnZsdVxjqy8w
 j+Y2R0kwqUYsryLRJfXGE787RrglOU0GSmlH+6WEz3LEjpXr3oCmiqBmBxMkbXJzqoPgnQ4
 ShIpGCOiS29PVGhbZCZSbn1OXVgswYKq61nK0g1Nh+7mTEwHp2tNL6CnxQrKDLA0HMRoPSp
 4ZbO4E4SU0+36T64nIw2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PetKIkR3L20=:UER8cuO9ngWL4Qg5aR2wRD
 tkaGA8l8Q+RU9NGKhTpvNbs5adQ+ZOa8P5D9kpzUhlCAECyba93KOneuRfTrQujl9Ckl3ELSh
 xuSuWbIVQRDv1DfP+jHiOZCjqHTIK4NxvocpAi8w/nZGsUpCGfoOwnXimMAlhkXHiRuT6TUKJ
 8ciQsb/mbI5vybrgGgOXQv7/KyuZtGFKHJHJT1J0lP9n7JH9DMwsG9JD/1sAQ2K8R7jRwdZx7
 lRBUvuNdyNC8J3sD16281lFq9D/NI7tIVip9vuC5HEN2UXf8AybW4VJIgqvWtAGosC0YzooYy
 ciS0zuhc2pYSB3rcM6ic4/7+DGjjp9+OPlkG5RF7sfQ92HQvXql0G7YMznouhPHnDgaWeop/R
 pZyYbB2TND6Mm/JoYW/rhdU8hFKlDYTgfURIGHjVOUoik1l+4w9/l7dl+YOiK0xheg4mE0/oS
 hSOIe5HIri0Ga49AmB2ujzZfjXXOZB1FnwjLhO6mGmbahnTMYw4CsYNXnEbc1AfNsei2+5gbb
 cpizpJmm6Ixw85NpUNIccRuuf6NA7tZhsdVVQkVGA3ANZvVf8FMT2xAdV/hmCeMe7IK40tO4n
 Z61MX85zBZFEa7f3o6D+e/I35vXhVTSLnau4JTKMaMa4Uid6TcGz1EfhYYkA074JmGFLHHt0D
 YI3ncfQm0BZiR7gyLP6/MD5uaN2JjO0xInvCkPUH3LkVzZYm1TTtq38Rl3DkPgPx4BoAlOSDX
 i5v16chBsv6vx8ntnyrlmZyxMIZTH0JESecYs82jnt5XKB9gg6d2/hc3Or6kgdTlI9GpjJPct
 w5tiptlzxsv3dxNBR6YQIuj053KS5stsSPmOWzDLqn7luOg1w1KRNkH4DEZYwIpkXU5tyBO3i
 ruN2AWJ71Fex84KaOfE/+A5ieBFSneXF3k+7z1e+xS/Xg6yM/P4bEQJ6orNWt5fZ0q4BaCYK9
 qjUaxDIahPe2bhHO1qtbF3+9UwvnTQmSzOF7fm1rsWMw9j3OdwRMql3O9lyObVizOUCJQP+a7
 M2Nw/ikn/ZGzvnzzIKUXRmEMco9RjAqFDtTCuB45tiKmAPU49krIMjHP9QqEIfqDwHaEZRDcI
 NPHpQORJGTR2FLZfN98gzsi3imsGOEVxYoDo66P6GNT9Kv5cXbwKdQ2HZxmENJr5BPklq54FD
 NudZP26/bHrODlU+hvXl4POUFsjxI7Frsrb2peErOdpx88W47oNfLCU4ZEZfxaK/8Ju/L5ThX
 E+7Jid40vzywwkM93
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> This data race was found and actually reproduced by our concurrency fuzzer.

I have got the impression that this patch series has got a questionable
mail threading.
Will it be helpful to resend it with a cover letter together with a few
adjustments for the corresponding change descriptions?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=d5eeab8d7e269e8cfc53b915bccd7bd30485bcbf#n785

Regards,
Markus
