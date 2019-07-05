Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30160039
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 06:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfGEEjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 00:39:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEEjf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 00:39:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so8423796wre.12
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jul 2019 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:openpgp:autocrypt:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=h394izWr52rxbfeoB/kRaXH/ldLE3rWdnsU/fMLmuNU=;
        b=VEqHo3vI+11fNN3XP5p+ORTIMUVhMGQoGb0XU/PJMCbOjJFDmU87LOsKqkLqLWqYWv
         w/imwiZs36LEkxB3b8qxi6Y7EX70xw2xn7lNTN4picdK7Ufx16kDFy4h4JovqX4D8jx7
         lO89ZLUwFOTnc/wlSJuKzmI+XdTJyXUH+rUmjEYsPVqShK71uP2sqVQQVCra/ihiqNPb
         D8Kj730RrMU8HdGr68pnSo9ABqSE9+4pNyJxQ+2XzkpoS5JmOK8bZu3a1RDo+pHUH3Pb
         jx2ILxsP5N7rVbaXXbpGBHQA26wZlJv2/3Na4QY7xuPPeMM2Lq8I24ompqns5uTPPPId
         cE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:autocrypt:to:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=h394izWr52rxbfeoB/kRaXH/ldLE3rWdnsU/fMLmuNU=;
        b=hZo8/CuYVQNeTcRJ23M25fIaSiLEV8fAQxWv7LgpdlePdO5K3Qn6BGBorkaZjBnL0O
         YpRMxI1Kh3qZVTAHg8ldMYQB9CwfR8y1lHxlAMHoKYTOQC8CSiuUv8um4PPtcu8HyJV9
         35etlCh+akdHNV0o3Jwb0U+DR9hydv4VZ6WWInHf8aA7A73WJ5Jc9wcPBQPvdEppIhnP
         xGsQwCsDeuyJxPEkzjN7t8q4+HBkp9y2JLW0SxU0CKAe4fSbfCNfz/QGuwupbgQsEQ1v
         2nFeSM7zdBKd4zBHd3vgg3Ig6eE8iKAF0IIZ3kDT8z2cxnbLM5f8TXV09z9SOiQQ5M6u
         80lA==
X-Gm-Message-State: APjAAAW95h3vMpW5k0YARzYFDnvbS5SbjT7JdHV8X6nQpDq+XLmJHhEW
        F56st+pETpV5CebAAkKRQk5rsE37Uho=
X-Google-Smtp-Source: APXvYqwutSB8vok49Yw8bvFGpEq2OIbLoxH/tVH7PatPnEhG3eCHjnf9efVy81CpDUWzEHwJewuMTg==
X-Received: by 2002:adf:e588:: with SMTP id l8mr10428wrm.139.1562301572583;
        Thu, 04 Jul 2019 21:39:32 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id w20sm20729032wra.96.2019.07.04.21.39.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:39:31 -0700 (PDT)
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Subject: "kernel BUG" and segmentation fault with "device delete"
Openpgp: preference=signencrypt
Autocrypt: addr=thecybershadow@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFar2yQBCADWo1C5Ir1smytf7+vWGCEoZgb/4XKkxrp+GUO7eJO8iYCWHTmCPZpi6p/z
 y6eh+NYcDQSRzKA99ffgdN+aT8/L6d63pYdsgtDmX/yrFWyLOVgW62LQpC/To4MTJAIgY/Rg
 /VjdifOJtYFvr+BKJwFCTfcviy4EQjsfHLnyJjvL9BiCXfSBXASc/Gn9WOTL5ZNpk4TStGXO
 +/2PIKeg228LtJ5vc/vemBo4hcjJv9ttX7dCebpSAbNo7GgOs8XNgJU2mEcra3IMT15dGk0/
 KpGMx7bMinTIlxx/BAGt5M5w8OnNi4p2AcKzvH18OTE7Lssn5ub8Ains32hbUFf18hJbABEB
 AAG0K1ZsYWRpbWlyIFBhbnRlbGVldiA8Z3BnQHRoZWN5YmVyc2hhZG93Lm5ldD6JAVEEEwEI
 ADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS77RsIjO1/lYkX++hQBPD60FFXbQUC
 WJ9eKQIZAQAKCRBQBPD60FFXbX0yB/9PEcY3H9mEZtU1UVqxLzPMVXUX5Khk6RD3Jt8/V7aA
 vu8VO4qwmnhadRPHXxVwnnVotao9d5U1zHw0gDhvJWelGRm52mKAPtyPwtBy4y3oXzymLfOM
 RIZxwxMY5RkbqdgWNEY7tCplABnWmaUMm5qDIjzkbEabpiqGySMy2gy6lQHUdRHcgFqO+ceZ
 R7IOPEh2fnVuQc5t1V56OHHRQZMQLgGupInST+svryv2sfr5+ZJqtwWL3nn8aFER6eIWzDDu
 m9y2RZnykbfwd56c81bpY6qqZtHkyt0hImkOwOiBj3UWtJvgZ95WnJ8NBPHPcttgL3vQTsXu
 BRYEjQZln81tuQENBFar2yQBCADFGh8NqHMtBT8F4m/UzQx0QAMDyPQN3CjKn67gW//8gd5v
 TmZCws2TwjaGlrJmwhGseUkZ368dth5vZLPu95MVSo2TBGf+XIVPsGzX6cuIRNtvQOT5YSUz
 uOghU0wh5gjw7evg7d0qfZRTZ2/JAuWmeTvPl66dasUoqKxVrq5o2MXdYkI6KoSxTsal3/36
 ii5cl2GfzE+bVAj3MB8B0ktdIZCHAJT8n+8h10/5TD5oEkWjhWdATeWMrC2bZwFykgSKjY/3
 jUvmfeyJp56sw5w3evZLQdQCo+NWoFGHdHBm0onyZbgbWS+2DEQI+ee0t6q6/iR1tf8VPX2U
 LY0jjiZ7ABEBAAGJAR8EGAEIAAkFAlar2yQCGwwACgkQUATw+tBRV200GQf8CaQxTy7OhWQ5
 O47G3+yKuBxDnYoP9h+T/sKcWsOUgy7i/vbqfkJvrqME8rRiO9YB/1/no1KqXm+gq0rSeZjy
 DA3mk9pNKvreHX9VO1md4r/vZF6jTwxNI7K97T34hZJGUQqsGzd8kMAvrgP199tXGG2+NOXv
 ih44I0of/VFFklNmO87y/Vn5F8OfNzwiHLNleBXZ1bMp/QBMd3HtahZVk7xRMNAKYqkyvI/C
 z0kgoHYP9wKpSmbPXJ5Qq0ndAJ7KIRcIwwDcbh3/F9Icj/N3v0SpxuJO7l0KlXQIWQ7TSpaO
 liYT2ARnGHHYcE2OhA0ixGV3Y3suUhk+GQaRQoiytw==
To:     linux-btrfs@vger.kernel.org
Message-ID: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
Date:   Fri, 5 Jul 2019 04:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm trying to convert a data=RAID10,metadata=RAID1 (4 disks) array to 
RAID1 (2 disks). The array was less than half full, and I disconnected 
two parity drives, leaving two that contained one copy of all data.

After stubbing out btrfs_check_rw_degradable (because btrfs currently 
can't realize when it has all drives needed for RAID10), I've 
successfully mounted rw+degraded, balance-converted all RAID10 data to 
RAID1, and then btrfs-device-delete-d one of the missing drives. It 
fails at deleting the second.

The process reached a point where the last missing device shows as 
containing 20 GB of RAID1 metadata. At this point, attempting to delete 
the device causes the operation to shortly fail with "No space left", 
followed by a "kernel BUG at fs/btrfs/relocation.c:2499!", and the 
"btrfs device delete" command to crash with a segmentation fault.

Here is the information about the filesystem:

https://dump.thecybershadow.net/55d558b4d0a59643e24c6b4ee9019dca/04%3A28%3A23-upload.txt

And here is the dmesg output (with enospc_debug):

https://dump.thecybershadow.net/9d3811b85d078908141a30886df8894c/04%3A28%3A53-upload.txt

Attempting to unmount the filesystem causes another warning:

https://dump.thecybershadow.net/6d6f2353cd07cd8464ece7e4df90816e/04%3A30%3A30-upload.txt

The umount command then hangs indefinitely.

Linux 5.1.15-arch1-1-ARCH, btrfs-progs v5.1.1

-- 
Best regards,
  Vladimir
