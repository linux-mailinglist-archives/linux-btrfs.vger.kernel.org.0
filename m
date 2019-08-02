Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B378000A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405958AbfHBSIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 14:08:13 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:44912 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405231AbfHBSIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 14:08:13 -0400
Received: by mail-lf1-f42.google.com with SMTP id v16so61621lfg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+MBiQLXRjop+bRX9YqAMPbFJJ2kL81fNurZKMTS8t5k=;
        b=c9BD61qCP+S9ljLhdCLWl80K0e0WgqxR1HOq2UjT/zAsjU5wnGotMm2HqakQOOs+cX
         4Ixgj6g5YUxCPaKVzqSdFUx9RBfm9LtDo0BgmV6T/pKWngzQe22T595n7Y3sYbuSGRGF
         JkSxoZ/FLnHPGwMQiGOAWZM683zrnlB+HlwCgyU6KrxYeJ1b99fQA6fOYoyDyDrOFc1u
         w0bzxSgHHKlTgB+2U4JsTX2SYitvCMA1id+aSikqkOARGMbYTPhZQsMVfXZXDOfZ10Rr
         Bu52lGQvz1HYbiaygv4eGNPBHx6l05EDH/Yh+KNlKOGvvaYMXxgWRBC++KqtKwwPDKWq
         GV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=+MBiQLXRjop+bRX9YqAMPbFJJ2kL81fNurZKMTS8t5k=;
        b=RXgXQRsM/iXex5YjjuI/2zSji9UvrxBwZ+GOYKw+ASXzDFqSB4r840GavDn0fZBiiQ
         R98iXaVm7nmOdtQvYJqjibfYWYng1D0B/3kZxdj6d2rhxE0pOXJurzuthQQesXG8clMG
         AN/LH4ujaWGcVZjvpn4HM0kI3v88a7xJ2KLLGNnWmySyhjMtUc2oPIrIfdsfmkcc+CNb
         IUU79JP1XvCzWghNj0GNfaCojWI1spkc/Dgaam0LV+u7BYMczK4ysbPS+VSsG+cS2iIJ
         wJEj/HYlD1rhbCZh8S3QeC7y2v0YHf4utxf+Vp0oD3/BtvYNmxPCXZl4cHFAGWhyfmXI
         me/A==
X-Gm-Message-State: APjAAAVb8KJN4BQh89OKkF3fP2lu3htSaXOh+nPXK08Neu/O+5LNbw3p
        h65wIcZV5H65BjzI5GNnDM6lPlXQ02E=
X-Google-Smtp-Source: APXvYqyuNe/YDb355ges5sTWPx+qu1xuvBREXYu7hnIK9d3wiQRPqQ98xyRpEyR2woeUKUFplxh9lw==
X-Received: by 2002:a05:6512:70:: with SMTP id i16mr63717268lfo.26.1564769290161;
        Fri, 02 Aug 2019 11:08:10 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id z25sm12946096lfi.51.2019.08.02.11.08.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 11:08:08 -0700 (PDT)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Non-existent qgroup in parent-child relation prevents makes qgroup
 commands fail
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
Date:   Fri, 2 Aug 2019 21:08:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bor@tw:~> sudo btrfs qgroup show .
ERROR: cannot find the qgroup 0/789
bor@tw:~>

Fine. This openSUSE with snapper which creates and automatically
destroys snapshots and apparently either kernel or snapper now also
remove corresponding qgroup. I played with snapshots and created several
top level qgroups that included snapshot qgroups existing at this time.
Now these snapshots are gone, their qgroups are gone ... and what can I
do? I have no way to even know what is wrong because the very command
that shows it fails immediately.

bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 0/789
(0/789 QGROUP_RELATION 2/792)
(0/789 QGROUP_RELATION 2/793)
(0/789 QGROUP_RELATION 2/795)
(0/789 QGROUP_RELATION 2/799)
(0/789 QGROUP_RELATION 2/800)
(0/789 QGROUP_RELATION 2/803)
(0/789 QGROUP_RELATION 2/804)
(0/789 QGROUP_RELATION 2/805)
(0/789 QGROUP_RELATION 2/806)
(0/789 QGROUP_RELATION 2/807)
(0/789 QGROUP_RELATION 2/808)
(0/789 QGROUP_RELATION 2/809)
(0/789 QGROUP_RELATION 2/814)
(0/789 QGROUP_RELATION 2/818)
(0/789 QGROUP_RELATION 2/819)
(2/792 QGROUP_RELATION 0/789)
(2/793 QGROUP_RELATION 0/789)
(2/795 QGROUP_RELATION 0/789)
(2/799 QGROUP_RELATION 0/789)
(2/800 QGROUP_RELATION 0/789)
(2/803 QGROUP_RELATION 0/789)
(2/804 QGROUP_RELATION 0/789)
(2/805 QGROUP_RELATION 0/789)
(2/806 QGROUP_RELATION 0/789)
(2/807 QGROUP_RELATION 0/789)
(2/808 QGROUP_RELATION 0/789)
(2/809 QGROUP_RELATION 0/789)
(2/814 QGROUP_RELATION 0/789)
(2/818 QGROUP_RELATION 0/789)
(2/819 QGROUP_RELATION 0/789)
bor@tw:~/python-btrfs/examples>

And even if I find it out, I cannot fix it anyway

bor@tw:~/python-btrfs/examples> sudo btrfs qgroup remove 0/789 2/792 .
ERROR: unable to assign quota group: Invalid argument
bor@tw:~/python-btrfs/examples>

I can remove parent qgroup, but it does not clean up parent-child
relationship

bor@tw:~/python-btrfs/examples> sudo btrfs qgroup destroy 2/792 .
bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 2/792
(0/789 QGROUP_RELATION 2/792)
(2/792 QGROUP_RELATION 0/789)
bor@tw:~/python-btrfs/examples>
