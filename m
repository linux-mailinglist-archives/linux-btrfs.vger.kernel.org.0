Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488E623DC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbfETQpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 12:45:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35433 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388796AbfETQpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 12:45:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so58020wmj.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVcCri+AEIktljEBPjh6Zhi+3fgQ3tYmp0k1KRXCkt0=;
        b=fWSYSkMlrqQsrhQqLVTDu9S1Xz93dHsQPkQZsEWJr7rhuMJRiee83Z6OGXNKNiw5nB
         B7ZuBtT5RdCrncnLO2jstZCUJX0ncmXms5CWUpVS/N8nzX7CCFug5l5glONCDwv6iGUk
         giF85XLs4lSvwqABItd3EJg2ram4qr3CFER6xDVrpVT0Fwc9ItLHcauRC+RjuT6F+B/3
         j5NZwnHAS7ax0jVFaiXy7m4TebC/TNumWQriDj2ITvsbs9v1+vCZaxIl4UoCa4WRUwUz
         D1wGQIutNok1LH8HvC5IktnWMaW8Ah4TQV80oGS9Mlr/yLSIy/+KP9Xm3uDB+nxr0b6T
         tGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVcCri+AEIktljEBPjh6Zhi+3fgQ3tYmp0k1KRXCkt0=;
        b=MpVDpLi/a/Epu5w0i6OPM6hR4h5B2jpVVIvUqHGHXdZhqtVpRpHSo1nzO6Lc9FmkZj
         6p9wmqm9GcVyB/FJ8Cg9FL7weO9fmWn3AyLkyV19uz2QTD0IMj0S+eLB24XT+/Lp9jZa
         wXMSAP8YtrTq6Qp1DA1MmyW6YkSf9yb8sX8o3BRttEiZvGb5OAYZROMU9asgWoOX6H/M
         PLDtkfgF/NRS1nULoVlMKa5mlSZdFAseZNGnS+Wu/tHzU99pcPZQ0aFmmjdUCx3qherP
         CDX3KixfE9sfS2m0jTbQDlmdeNRfzIEbwTWctPtBapNx72JyFeku4ulZT77R18HcJEeM
         V+Ag==
X-Gm-Message-State: APjAAAW9x77SUFr/bE1ik/r3wsAbJXkdTn8ZZLRk8HqamhmftFTaIAdn
        d5js3L816XAO2MWgK93s8rQ=
X-Google-Smtp-Source: APXvYqwZYII4urrY03OVQRdBJaVH9H80p+yhyfh8IKA4G7HJovsn0UDqiciOFcitenXwWK8lXgbXOA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr40749wmj.33.1558370706594;
        Mon, 20 May 2019 09:45:06 -0700 (PDT)
Received: from [192.168.2.28] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id a10sm21043230wrm.94.2019.05.20.09.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 09:45:06 -0700 (PDT)
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
To:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dm-devel@redhat.com
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <CAK-xaQYPs62v971zm1McXw_FGzDmh_vpz3KLEbxzkmrsSgTfXw@mail.gmail.com>
 <9D4ECE0B-C9DD-4BAD-A764-9DE2FF2A10C7@bi-co.net>
 <CAK-xaQYakXcAbhfiH_VbqWkh+HBJD5N69ktnnA7OnWdhL6fDLA@mail.gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ea5552b8-7b6a-2516-d968-c3f3c731e159@gmail.com>
Date:   Mon, 20 May 2019 18:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK-xaQYakXcAbhfiH_VbqWkh+HBJD5N69ktnnA7OnWdhL6fDLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2019 16:53, Andrea Gelmini wrote:
...
> Also, changing crypttab:
> root@glet:~# cat /etc/crypttab
> sda6_crypt UUID=fe03e2e6-b8b1-4672-8a3e-b536ac4e1539 none luks,discard
> 
> removing discard didn't solve the issue.

This is very strange, disabling discard should reject every discard IO
on the dmcrypt layer. Are you sure it was really disabled?

Note, it is the root filesystem, so you have to regenerate initramfs
to update crypttab inside it.

Could you paste "dmsetup table" and "lsblk -D" to verify that discard flag
is not there?
(I mean dmsetup table with the zeroed key, as a default and safe output.)

Milan
