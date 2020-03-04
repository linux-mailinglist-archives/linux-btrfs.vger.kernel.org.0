Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48917990E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 20:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgCDTaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 14:30:15 -0500
Received: from fe4.lbl.gov ([131.243.228.53]:13770 "EHLO fe4.lbl.gov"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgCDTaP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 14:30:15 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 14:30:15 EST
IronPort-SDR: 1VZwJX86ZpTTcArVrr9UBwPUxFuonI02EE8WBmQ/rfOjxAlTlHBlu9B9/Zt1AdEQGuvYWfFYbb
 n0MFMQZGK+Pg==
X-Ironport-SBRS: 2.8
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G6AAC0/19egMfWVdFmHQEBAQkBEQU?=
 =?us-ascii?q?FAYFqBQELAYF8gW2EcY8AhX+VaYFnCQEBAQEBAQEBAQcBExwEAQGGRyQ3Bg4?=
 =?us-ascii?q?CAwEBCwEBBgEBAQEBBQQCAhABAQkNCQgnhWuGURGBCwImAjYBBQEWGQgBAR6?=
 =?us-ascii?q?CRT+CfAWhFoEEPYsogTKJC4E+CQEIfCoBjCYagUE/gTiHQQESAW6CRIJeBI1?=
 =?us-ascii?q?bigFGl3qCRpZgIoJJjDMSJ4t8qj0CCgcGDyOBRU49cSsIAhgIIQ87gm1PGA2?=
 =?us-ascii?q?dBiCOewEB?=
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="97040658"
Received: from mail-pl1-f199.google.com ([209.85.214.199])
  by fe4.lbl.gov with ESMTP; 04 Mar 2020 11:23:09 -0800
Received: by mail-pl1-f199.google.com with SMTP id bg1so1508184plb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 11:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=ICxY4Z4VfA/lINbM3u6hqo7FfxB8YmaKFeSoXwAm2TQ=;
        b=qYyOkgGjq9sn74dtulYeTyTtKn9Zz0xjWWGKDb+pCUiry8oYfcFDKZ2VXf7w3IH2fI
         uju6vIGuGXw0YvBtfteKg7L7T27RgCl+QZP/6j3NDKi41Bmu+uXfmgVjJ/fKduu6TiiH
         KV2/woCpvgY4oLGzbPu+kCbrq4/200ZS1f8kY/GWBQsEaB8e5HuuJVN4BNWVCQk/ZSnc
         5RCNBqW0oBB9yz4qi0ogT4AAvCkZvo65j4LRoYWo8Qt0J9PJiEJObPKaW/BdN8NuFSJ+
         n+wtq3RVuYaVkA5msuYswjbqqBRS26XgOaLJnTlqlM+e4OfoSamHAvFw+evj2wN+X4Cj
         YRKw==
X-Gm-Message-State: ANhLgQ0R095xVM1LgmwkZnaiov09uMPjDz4SvQYyr6SKdrt08lWW0Xtw
        QnBGwyNQLgFYLaS03Pg1jWKOwlYJV8SWHOcAgltkJrcPksFBesaqxR5kFoRr7ZWzcN6dZnKQ0ae
        cWI5tQV0b3GRNbMRjKuRZYtir+w==
X-Received: by 2002:a62:fc8d:: with SMTP id e135mr4536714pfh.134.1583349788277;
        Wed, 04 Mar 2020 11:23:08 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvHYY0k00LsKx8aHc2D9EtKitLNEXQLTCd0rOnPh0H0qwZldHrCasnvbR8Edmqg6A9Jh+A7dw==
X-Received: by 2002:a62:fc8d:: with SMTP id e135mr4536690pfh.134.1583349787820;
        Wed, 04 Mar 2020 11:23:07 -0800 (PST)
Received: from [128.3.131.12] (apersaud.dhcp.lbl.gov. [128.3.131.12])
        by smtp.gmail.com with ESMTPSA id z127sm28784388pgb.64.2020.03.04.11.23.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:23:07 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Arun Persaud <apersaud@lbl.gov>
Subject: problem with newer kernels
Autocrypt: addr=apersaud@lbl.gov; prefer-encrypt=mutual; keydata=
 mQGiBDtE7s8RBACrbdGLHOUUZD9dDoE8Ogachh4JaLVc2S22ijcqYzCzfI6BzUrnHtTXtgdT
 Ob2/ngs4StFtTGmLPtH38Xw+Nmr5Js9K1CiJY8eGi6009gh7hiPdIDV1Bc27si1NED7FF2Db
 DFQWCLbAc4ymJRYfgJxzvCHrOnDbKmYHn7FODb/rDwCgxokmd848MdQnqgEM4ta6Uz2vGn8D
 /R6WwlDaxdc0b9SUUawVbDDZnFP8ffJVc8LVzC25HljhYHczJRq4K0oAB0dgxgR5DgaFypUi
 vzrGd4SzbIHvwxBw04s0yEyjYKExA9yWQvCLyACDPcnYnkkEeSzGb7tgFMMIp+BPHDAGsfRE
 FfiPSCQB7UGSJfb1TOSK70ha1LTYA/4m+L+va0d89fT+rkclgvWlJEN63t225fqs4UWUZYPH
 67Hy3puzuBLap66DasMIsuEoxmkpndfaLwewSkCsxetr1lwKUWDywqi80mzI00NqpW6RIXQ/
 udmCaXnaxjZyGbC/b2jvzUvRuvxdxzHjr/xUWd7/1t0SsP5SL78fO04RU7QfQXJ1biBQZXJz
 YXVkIDxhcGVyc2F1ZEBsYmwuZ292PoiABBMRAgA4AheAAhkBFiEER9IGaaHtSGwCV8A2Kgx8
 8fUbxTYFAltd+PUFCwkIBwMFFQoJCAsFFgIDAQACHgEAEgdlR1BHAAEBCRAqDHzx9RvFNj8T
 AJwNuZdMpbr4JPLZbSpGZNXOa5lL5wCgkc0c7f8px1GzlhyklJxpgcMbzsG5Ag0EW13yPAEQ
 ANS5ePPQ/9KwWAFyv0iiF8PttONA9u2T+quOJ3Eiot1E8YjY3UbJsiNeP8iPens8galhwcPI
 van/AMnktvOk2IzzKX825doGb4QH5Zl/btcUbmEhX6xJ2aPMsJK3gGjBe9Pjap5ENoBYh1VF
 rOxTDSxZV11R3rwJOOqTT7xvAMButKOkpg0ZuLRq0795Sm3WKFXnvfUeWURqNsTTO+BL4JQZ
 3aESpgCIMAz0P57WmIJizQMQfGyg+PE3sE0zuMnaHRRT97wl+bt+S8GRTITggmbHBbUAJDIO
 YUgYrI4keocYqPKI6F8ZtpjY/uC2gAPgmH9t1Mzr2HtSe+mgeK5BwRsp5sWdTHkoNcvkeVat
 MiDBCH2AVaqrzfumCurEYgfBAl2p1DnGqjIkNfl5CqX28kA9nK813eJwpwg6JzG9vPny4ZKd
 B9URMLGTxoDw2p5M8sQG0jHvEcTBbIHu2YKa2o2pPJnL++1oMe/YmUJxXQqwizbWyEaudnxl
 zqkRcVQESesOWxtZp+xVH+nU2UMUwV0lOs5gvyx9LzLUCz/fbya/H75hXrYEZYzKEk3V6xm9
 9HGQf2rfTnLTH+LV95pFHiWAUb7TuMwKODoWxQqQz9aBN0RntzhJD4MVXA7Ia2MixZ4EnFxA
 Vmx01C0k6Kxu+7lvw7jSdvQJ8GPrIeH+h3OxABEBAAGJApwEGBECACYWIQRH0gZpoe1IbAJX
 wDYqDHzx9RvFNgUCW13yPAIbAgUJA8JnAAJACRAqDHzx9RvFNsF0IAQZAQgAHRYhBIrwqbVy
 85vj7Fi0ugv02V5DUCzHBQJbXfI8AAoJEAv02V5DUCzHIk4P/RgLj8jw/0AFIWuK2bBxv+SW
 E/fSGXNobPLgBg4kgT/FFHEtYinxbrrpjRtinIdciZ6XCRgtfdzZ2qpiO/Kf+h0Fwlq6OGwE
 rV1WhEVqH183FMlpS1HLVSs/Yjw926zcIkugIpbIdA/atMbewwvh2JA6hv+eHSu7YWfd7GyF
 cplmCk1HTQIPThq5AbSl7g7ATtVRii5czAilLLRwsSBmt49DeOZ7axHW+jxHg9tphUDr9Srt
 ONVeXTOEruVaWOydUlhNfAnYhW2IvZCjwzKfOE9sFkqLCPwa9ZuEYTFBH087HzG3phYfNTDe
 Lc7AWbiWj3ClpLGoPPussWcSIrRUcanREOisWxDieg5zESxKHL1Kx/bgEnOUFh4YHU0Y6whT
 I3mg0y81S0KtLbAJ61NDYJ+rzKpGdJJ5JvQLiiwM0Ajo5ujcyNBlE2/1TW16ntCcSaJuCGzZ
 nQ060RMdEk91vFzeErxy25oc+NSFkGdQKkBjeJ2ld8O429p2DMDg2yjfp2eOoAMyxxs2BjVo
 iizcSWQ03hHv1xoD3wGfCHMJoqm8G8ZGOhP6ZcKbZK4P990F2mJqTuGeBqvgMbg/WkcOhAsJ
 bDQ/SJKBLCZ3EaWAZkQ5FylDCEE7k6iJyC5xH4321Mpjo8iFJ8DFseiwd7L+3p76XkvsA/i+
 UEpok82kwvG/BbYAmgJk84XxIrhSuzB1yZu8bSuSSu8mAJ4yglDqNgKqtvUkw2kAtSoC3DcX
 57kCDQRbXfV4ARAA3Kl9gCj2o5OHACup7XdhTftzGZWWIXOKACuukwFPm0Ty7crArIHAsUIS
 +/NcP8GxQlQXjLOi1DMckC947oNze96xsAkMUEpcs4Lf7Fcdy+oiOoVH69cJJCG7K551eRvX
 /jiWbnX1QZIGEt4v1iW8u075HGi7Fd+7yPA+kjyfhnFxEN99wwZzivg+BuqiM5DbSDCHqxnf
 cC1wsDNaep3igr6VSw0ZTSoXi1MJbvsIvc5cN7HTKKnkU/KGADHbyhDYtYwJ7NvboWIyv1f8
 8K7TV/W90J/DJbAcO+ovp4uAHBYOHwpKDyNy3ELlRoaob8uX9syUZkXrL+kZrLXzW1+5t3Gg
 C6jZWutpTfEtjhfo873INgIFEMYmCWwHCSf1r+gKRAxHoC9Z0NV6F408WGsUTZ47y8xVhDvj
 vz2jYhAZQ6iRYjQPn2oGcsN4kTpB6HH/YauT3u0+ExX95+5wkbzHvzy+zdv/wPkHC2f8wUZQ
 KJAZbWTX6ay9vVrJr90kbOBjhACuLWh3sFldPrwmAfP95w6IN0/9wGZBFXNVuDt0iRk5ElxY
 xmhYzhOmvkr7SzVh4UNdGsetsbem60bcD//yq4B2gtv8oJ2cc1DYJQ6dsKCXJYB0I1gNtTd4
 BlJUW7Qcq2ZU2W6KcXuln3FdDzTnqnnh/nvX+hoSCzVPoUHO2i8AEQEAAYhmBBgRAgAmFiEE
 R9IGaaHtSGwCV8A2Kgx88fUbxTYFAltd9XgCGwwFCQPCZwAACgkQKgx88fUbxTYA8wCfVT+B
 Ej26APxF0uA6qduwr4FIRjAAoIzXfhF4dfzNMr8MtGCsZu+eqxPq
Message-ID: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
Date:   Wed, 4 Mar 2020 11:23:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

I use btrfs for a partition (/dev/sda2) and when I try to boot with a
newer kernel (on openSUSE tumbleweed), the system doesn't finish the
boot and goes into an emergency console and I get the following error
(don't have a log at the moment, but can produce one if needed):

BTRFS critical, corrupt leaf...

if I try to mount the partition, I also get a 'mount could not read
superblock' message.

This is for:

kernel: 5.5.6

I also got the same message for previous kernels.

However, if I boot with an older kernel (5.1.10), everything works OK.

I just chatted with someone on #btrfs on IRC and they suggested to run
(using the new kernel)

btrfs check --readonly
and
btrfs check --repair

this was with btrfs-progs 5.4.1

both didn't find any error or repaired anything, so they suggested to
email the list.

Happy to provide more details if needed.

I'm wondering if I need to format the partition? But wanted to check in
here first also to be able to provide logs if they could be helpful.

Thanks

Arun
