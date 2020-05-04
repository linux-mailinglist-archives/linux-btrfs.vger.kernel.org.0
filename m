Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769311C314A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEDCJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 May 2020 22:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbgEDCJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 May 2020 22:09:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FDC061A0E
        for <linux-btrfs@vger.kernel.org>; Sun,  3 May 2020 19:09:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l20so7818092pgb.11
        for <linux-btrfs@vger.kernel.org>; Sun, 03 May 2020 19:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=flJuxYZbQXmHNjcZS0YgRdz+BKWBQ3AwgqOATJpUPv4=;
        b=qFaBOKlpEcquhvGYRom8cUopJSE8ryZ3ucs9ZbvuS9Zf9BjlS4+CEm6nKgYDR/UCAC
         S6zFSqRbqDOGFXMIM+HWeFePFTH03cBbxPS+sq6Da5IT717hS/b1Zw26aNQBDGSTxNeT
         EznSFnqrUNCKe51VNDt+hOgksXTu3VbIoHA+XqpRNX/TDFVrDS+addIE3G5VqCaOH/XO
         QurSBaCeBjMwqpLtUzV/f5iCyyFK+GP84+NF9hDF3+MBk+8R4y9rhrjFLFEGtAiiVlCB
         zrkB4r0qaBKWXTFlyybwraPc2Ni2gF7JAWO8XhWzwz1+eo+LpRSqugwlmW5nK1n7mV5u
         ovvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=flJuxYZbQXmHNjcZS0YgRdz+BKWBQ3AwgqOATJpUPv4=;
        b=T4uq1A++QU4mY3Cu6ql9TPsT12zgV8fFBHtNxQnh2ugnioqQvmeWmiCc4AfjfUXRK4
         I+bvSmbaC/qoKfH5ASoTvxKR2AfkZE9E4/z1eOwTBli2aF1IxOisA7vmG7+UpBSVkLvO
         ghr4bCKY+Cop8cKJeoZvatr8gxyipCzfBqFrkW1tHHv5UY7pgDP9H7y3jpkyKhuaaEVp
         GCyfjYcPHc9Ljl6qBer2mRD0jSx5FsYFBeg+IVmmLPNGMCQZVHZmBmzGILFCP1WB3z7O
         NRZkJtzYW+FMz3zdgcDLNne2Xkhce+uV0dtywRY1WbsFjVkwTKQGPk5UVoV5YLadU8xc
         s4Mw==
X-Gm-Message-State: AGi0Pua0WZG3iLw+wT7ZxkSHwd9H4QNLMI/zmodxL1i0FUVlT+D4Bgmz
        NBGS/JVrCTnrK3zrO2fLzIH4AGK0hYJTxA==
X-Google-Smtp-Source: APiQypLuj48SnUqSIuAie41+9l9Fpp0uVn9hxDP/4zaSpruftxljE27ln+kqBysZoWDiGwuja7lUYw==
X-Received: by 2002:a62:cf06:: with SMTP id b6mr16419514pfg.9.1588558165357;
        Sun, 03 May 2020 19:09:25 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:4dab:0:c88:4921])
        by smtp.gmail.com with ESMTPSA id l1sm6575732pgn.66.2020.05.03.19.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 19:09:23 -0700 (PDT)
Subject: Re: Extremely slow device removals
To:     Chris Murphy <lists@colorremedies.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io> <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
 <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org>
 <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
 <20200502090946.GO10769@hungrycats.org>
 <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
From:   Phil Karn <karn@ka9q.net>
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
Message-ID: <84f76b99-95d0-3c85-0b4d-70298592986b@ka9q.net>
Date:   Sun, 3 May 2020 19:09:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/2/20 10:48, Chris Murphy wrote:
> In my very limited sample size from a single vendor, I've only seen SD
> Card fail by becoming read only. i.e. hardware read-only, with the
> kernel spewing sd/mmc related debugging info about the card (or card's
> firmware). Maybe that's a good example? I suppose it's better to go
> read-only with data still readable, and insofar as Btrfs was concerned
> the data was correct, rather than start returning transiently bad
> data. However, I only knew this due to data checksums.


I use Raspberry Pis a lot, so I've been forced to acquaint myself with
micro-SD cards. I don't see *that* many failures, but the ones I have
seen are sudden and total, i.e, the card simply doesn't respond anymore.
I think I also saw one suddenly drop to a capacity of 16 MB. Electrical
abuse may have been a factor in some of these failures, in the others
there was no obvious cause.

I do trim them frequently to avoid write amplification.

Phil




