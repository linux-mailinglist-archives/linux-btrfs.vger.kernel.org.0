Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085C31F6986
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFKOBQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 10:01:16 -0400
Received: from mout.web.de ([212.227.17.12]:52955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKOBN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 10:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591884024;
        bh=c56enI6I5/M+hosAuiztGDVYwFDAzlVT7WCsV6L+sCM=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=BUdJwfEuIkaQ8DPsgKs9ftqAyxuXKhaAl/lLPssQsAkXsW41iqv1S01P2GbE+mc45
         y6+u7jtcGqK7AMvaWFqLzVfYll4Mewvp4CRvmxHr85LOPmrRw/RdZw2AyAHYRHyXo3
         nM/WVcoyssFeavKepyaV97LgRpK9tTs+iP8WDYbw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.66.14]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wzV-1izdmw2dU9-00xwKu; Thu, 11
 Jun 2020 16:00:23 +0200
To:     Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH v2] btrfs: Remove error messages for failed memory
 allocations
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <0bbb237b-3223-1efa-cf71-583a4e9ef3ae@web.de>
Date:   Thu, 11 Jun 2020 16:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:whnTkPmpFE3lRbBonsjH0mV+/M3G0rnebuRkCq90vQrDLxUUnLq
 U8HYF1f4e5gSYDAM9e+I8Wi9Cie5TChRsbS/OY3Zl6fc5o584cPjq6O3ulP+zNksXAyctoW
 se14+30ah7FnujW4tLTGLN+WImnLV79ONtGlzMY28FLXQX66pwEozREHxUdJ6mPR34BRvGK
 j5Dhy6eH1BnsXUUVp1xbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQkQ/uRCtpA=:k69DLVUKjpxdNE5Y5j1RSM
 29nHU6dybm6innEmBO5GB4juxl6xc1wH1CjSJW5BXeMz+UHHEVRMMY2l9g+cKcr5n2cmXVbMf
 rWUJinARcWCj08pRYCC00McSut+q4M7BOWtIzgkhzxIjfSgnpWhgdpTw/q7W+lzommAUVSbKW
 6bXcDeSO+u8iwGlcMosmFXm2BIISiWDNzc47dcUJAqnkRl6jMR+LsLWrAl1p7fT0bOUE36Lbw
 9QKDNcKvUoR9QKo5eo6iSmYUv7FEatkhX8y4WBIeoqfEHfMiShnel/xf5g+l9Z5CMeFThx5dw
 inON6bdgLS3Let8/gBPdgJKUt0NXXJ+nv9zEvNuc1mZTftooZn5XoCDUgpCszSYOgxMLaIN7S
 AZU18NngAhk1IzjA4pT5WbFagmAsNHuLz8gOVXwYnDTc8Ome+8/OMU6iBtLVxcTFOhSsdMmwj
 k2HCLzfkiuijaOEVbT0awUR5dkZXYDwDrfsWTFTP4ovb5QeaNwtkdyaf+vxfbLy1yFCA+zzJC
 dvMK0QHCWc3uZuapel3nNxGaECqgGhQB8J7UsmWpA+hFflFK95NfHAeps+ZbVgikd0KG6840b
 bkiKM01HB0pTUjsDX/DPWK5jf9ZyLrHF20Iyd+g/Q5qODCdLCfLXQoJxL5Q/JvDmAYVYF74Qt
 etS+dj117GLft4JOm++7EchH66GGYlzXd4GWIPdKHR7Ijk3t72yaxN00+yDC4AnBYNb0JfALM
 XDZjM+wSeTH52scnFt08rZdCewVlL5CzHrAO+K5kWz6ENdW1vG3yuORVM3Pe6ikYlmoAxB5HT
 47f2bZ6CLEioxbiPfNJ4Q5LapBrcrdepsXAsHP/BNQ1TuhG9j4v2rjAlxhWtCBjF6/t6fzgqy
 JZgV/vgOn7Bm187eLU6/5nMaoS2CfxM+4Bg65T4N7lzR5HK2n1vHchLi1CUNm8UeCfaYr+B+N
 Jufkdi5DpLOniTiDt1VnvjC3n4un7UeZAph5pwVl0SaKc3kPAPCzTDv+szkP20Dvs9w2VSOtz
 qk/53YE1yS1u4VSj/Mo9i9Ih0F1Im5nIQCf3UFdXfG1IGYCyUH6b8CerCeigugUo/b0kyhgLm
 OFqcv2cC1z+1CGXErSuaIXe64XfOMFzhAeMx0I+ajbT4YNgpcV+Qj+xavbeA+6X0cFVUFHqaI
 zv71RjbNg01IamnL5/Jyg4qcxj+LteDwPlicGaoY3bk0r3s8GDjsy4s8BzfVvB1a1g18WDf0w
 n4H6ggduZof8RMEel
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> As there is a dump_stack() done on memory allocation
> failures, these messages might as well be deleted instead.

* I imagine that an other wording variant can become clearer
  for the change description.

* I suggest to reconsider the patch subject.


=E2=80=A6
> +++ b/fs/btrfs/check-integrity.c
> @@ -632,7 +632,6 @@  static int btrfsic_process_superblock(struct btrfsi=
c_state *state,
>
>  	selected_super =3D kzalloc(sizeof(*selected_super), GFP_NOFS);
>  	if (NULL =3D=3D selected_super) {
> -		pr_info("btrfsic: error, kmalloc failed!\n");
>  		return -ENOMEM;
>  	}


How do you think about to use the following error handling instead?

	if (!selected_super)
		return -ENOMEM;


Regards,
Markus
