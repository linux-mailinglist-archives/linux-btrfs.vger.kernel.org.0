Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EF1C33C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 09:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgEDHj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgEDHj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 03:39:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44EC061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 00:39:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b8so71635pgi.11
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iiPYQ5Y4Pt4dQGz2VKlIteNBVIFb67aiy9rdv7O6oro=;
        b=r3ODmjjlG8b6z4u1f47C0f45NI5YR3ES7amxpXHE9cz8LRoLZg7n3ooy8EAW+s539E
         SNpa7unlZa3yoWngnt0lD8pZieRPmeMblAxzZgRm5xdj6HK1RIojELEp8mXHAkpUMetc
         j/rQ79QHAT4/F7SO+C+bQiQTN4U9/MYmPMsRuYEwfD4j78YtGPJCa76BG8lyeZY0vmGG
         9NcQXLEvd8VKK68CcHmQPOARQkqF7B2ame4YjtSf1U6FI8oXb35nbifZRM1J9W+hDvWN
         mZZk6+g8X70NmoSAUfMrQjMD2gI+b/qE43T8KH+qPavNCuKM4VdiHN7C39d0TBazDqZE
         citg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=iiPYQ5Y4Pt4dQGz2VKlIteNBVIFb67aiy9rdv7O6oro=;
        b=de7ccRTcLUcSFmBG3jWhcG6kRgsXlkVC1iqZh/jyl2O/ASOsHwdmErqxCK8Ss6QKSX
         PVUTYMi0s3IgkEz8jb03WWHyn8al648z6r0HLl1JnsTyeNrnZawGmDee9jNJjkUG+q/M
         6U66If2c+wUCb4XyofqDmxayMka8OkEuaddTlV50p4NQVEOurG3Yp6ktdhohst3cSw5y
         FofGT/OtnqbJ79XOdf0unKsZ06XMxziAFHbxfW2E/iqJM9nu8wobAj6hy7CxfRsv2qm7
         0VDjNQLik9b56SwD16ZWWQDqZeFj06zARp7VaErsTDZ5PV39fX/s2CJHOanpz6g+5VQD
         4WhQ==
X-Gm-Message-State: AGi0PuaWqaMVtwpoB929sbYdwHxtm5F+YO1e7DE9LJs87/eUAFrh7QRD
        7f4o/ytPvGBN/ozH2zowZah/Dw==
X-Google-Smtp-Source: APiQypKTiWQUZpcvhQKKXbf++2lRISASfEu/wpAwRPna5aBtlAXCXPjeqX13q5CrgIZ29xH0cq2DvQ==
X-Received: by 2002:a62:528e:: with SMTP id g136mr17221728pfb.165.1588577967610;
        Mon, 04 May 2020 00:39:27 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:4dab:0:c88:4921])
        by smtp.gmail.com with ESMTPSA id d10sm1662773pgo.10.2020.05.04.00.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 00:39:26 -0700 (PDT)
From:   Phil Karn <karn@ka9q.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Alexandru Dordea <alex@dordea.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
 <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
 <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net>
 <20200502041826.GH10769@hungrycats.org>
 <f8435e33-686c-e9c0-313e-a00e526a2b49@ka9q.net>
Autocrypt: addr=karn@ka9q.net; keydata=
 mQENBEw2mJ4BCADELiPsLFHDwapoSU7d2xNHxmwzzrFUCZWhO34kM6G5+o9GUNmGgMQ0BmXp
 I6hx77HHnrj9FC6kWh/bxBt3+o8HW+NTWzJSvf6kW7ThaNt7v9iewkS23JOMarAZs4qy6MhT
 1RW1/yWY7RimWxrmkKPTKKa0Ad4CWT6fcP3t+doqGslSQIeoTh0C33ZT+LY59Wcr224iXohN
 4Uu/nFe4yAHjtA+4Sesveo3Tyi8cbOgkcO6vij+pXesCcuhtGMlnE2dxRqbenrfVGLUVxNug
 LkQdLWezaGGm+dcjWYk1xjtaDnsCpVaYCMsfYNADQPJAjAFu37pVdoXhseVXfzOUN2EXABEB
 AAG0GVBoaWwgS2FybiA8a2FybkBrYTlxLm5ldD6JATgEEwECACIFAkw2mJ4CGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEPFOQ1TtRjRGU98H/Atsb/N4lNbzNdzdIRcHD9XgCEa1
 UdR4mxgjwvLxS1nYRNdHwfTxvA5nxWfMx/0CB26VaNFdI3lkg/S0vYsSUu6M7l8Zb8v4JMyU
 4B4yvkFHZ3II5oilzIMa3e2cMfDz7TSwO1JcXyI5y9vHnvH65/LQF+QojDgzf3vXKiNdTXJp
 3nEa5IgMAB0rcSNsXFx8xbHi8s5niL9+1I7XTPvVMeXrMe8h4AG1nM/dK96WwmV+tLyXKYXn
 xVeb9F4X9CNQbkn/xAH+egvKHHT3V7K9cAhrDfu9Qwpo7zKk/akBpLWG2kmkTOfhXjm3UQhv
 MVgDmpeQIYa1HgAsKrsDQMzrIFm5AQ0ETDaYngEIAJmFdm0MmENzLEosD1FvGPJleWDYb0ah
 8dOk4XUug1RhW40f7AsugT75pKs9PolXt92920GdU727X3Jpgdj4kLDtIQA0KZrOXiEOZjIZ
 WcROAyvTGyMs/P7Um1AGNM161Ga6/Wtlc076FN7EUQtzPbthH26M3lGWUX0Ccls/8Ep4qbnF
 IrMRBxjaxKbqfKPTeU10pDykzA7s5hiNe7qaegvqD6YLseZ+6FqCn988YnLiIaFeNbWxUY5G
 spjAsfesnAmpn5vhUqAGiizkNlAMIN31xvpLd93oM4/vORszIuN1UP2RlxL3s30BncZl2XOd
 Mk1/59Sy70zVqF1ANyMrA18AEQEAAYkBHwQYAQIACQUCTDaYngIbDAAKCRDxTkNU7UY0Rszt
 B/9ZPH9xw47lPkVJRbhgf0G7fdsxsyiuouAqOKklUNFSy4+qeGomjwE6YvdMybwGtaUGla7t
 2mDzrva+7Gzb0inXIgmahQPmM16F3GVxGoFL+QJ+7gD8Hco6e0/2kju7ZREDE7SOEwKb3lhD
 eNLccfX2AqAHfCT/LVLbgBpMRmwUJQThM+33Z2L9BqIM3awj2mOTmeDumpxiDfroU90mGc9c
 pXe4YrNIkL/N8eMzLe1bpu+mpPCiIrEO+dFA7N8jjVcOCQ4Lr8sU6cOsEdkaACZiNFKT99eb
 NkKigK8sEkDZc/AKhPCEsnaZpwBZPScOL88LLi7FHj9Osznt+uhWfbLe
Subject: Re: Extremely slow device removals
Message-ID: <2322cace-d7b7-7c7c-19a2-54a0cadf6d2e@ka9q.net>
Date:   Mon, 4 May 2020 00:39:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f8435e33-686c-e9c0-313e-a00e526a2b49@ka9q.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/2/20 19:28, Phil Karn wrote:
>
> Thanks for everyone's help, but listening to everyone else also talk
> about taking weeks or months to delete a drive, with terrible
> performance for other applications because of all the background I/O, i=
t

After sending this message I built and installed kernel version 5.6.10.
Then I pulled the drive I was trying to remove and retried the 'device
remove' command. To my surprise, it went much faster than before. Still
not nearly as fast as the 'device replace' I ran on another drive, but
it finished in about 12 hours. This was in rescue mode with nothing else
running except sshd so I could watch remotely.

I'm now running a full scrub; so far there hasn't been any damage. The
remaining drives (two new 16TB and two old 6TB) are still very
unbalanced. That's a job for another day, but I don't think I'll have
the energy to remove any more drives from my array.

I booted back to 4.19.0-8 because of some apparent incompatibilities
between the 5.6.10 kernel and my Debian buster userland binaries and
config files, but that probably has nothing to do with btrfs.

Phil




