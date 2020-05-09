Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF301CBEA8
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEIIA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 04:00:29 -0400
Received: from mout.web.de ([212.227.17.11]:47711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgEIIA1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589011215;
        bh=zrxLDBTMmEIP/qqOFO2evz9mc4UXaGDRoyYKqIZKBmU=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=B/IQVjRmP8sfSP8/V7MLjEWLx3rrOsrPd/mZhydg5iYFJuL0KyQW6coUTsgv9vi1s
         ddg9OURnBiPErO5xxn6YVHG0tblrf/c5QXr53RTH+EXppUxWukD0zT3g5KFijpoPov
         k507Q0b+Z1hoH/S74/4UT3LXGlAkLlL/jvW4tqsM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.78]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1jr4D91cmO-00K2Tf; Sat, 09
 May 2020 10:00:15 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/4] fs: btrfs: fix a data race in
 btrfs_block_group_done()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, linux-btrfs@vger.kernel.org
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
Message-ID: <ce41cc75-ee89-61fe-ef7d-6d527ea56e5a@web.de>
Date:   Sat, 9 May 2020 10:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tlwqMc8g4Mnq+exu4JXQPVrlV0T/nQuXVTVoAlwogzWnURg+6g
 mdQsGd9ebWDdIhQU8D6WNFBEOHXk5JDl7e4kfisY9NgmMyBfWNY9fgEpjDXgyp/bvYdRGLA
 VW279zWxVmO4EK3VBgdgxd+MRyXJmORTKGojJ9qg1LvkpiG8v+c5C4lWwSXjELtBTad+Lph
 1GiYp9Y3vHFZmB6D3ntWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IL4ulCApXVA=:axd6i3FmjB7fPueRGR+Ixe
 /KEwzjIySvIJjwRQ8UW1xkrbjxlzzjnqw+HpQYIgVRXA896uX5uSnf4c9Sr7PggjUr6NJI41J
 QiqkyCEM71ouok+FCGXhcFrGHRBzZv+2hkrcxC4vMYjJbHl5LTTmidg0fvsS5nKWcfCApSLvw
 NMJG9cO+JGkagXefquWAlC/5Dc1APhBr5hsFYcfc1/TVA6ud41UiS5r4y1z3LZ0MYvtbW42bF
 7U9HeRGOVOWvy9cAYdWMXlv9DkHLndqq6JXTqgX0DGKrZbSpPmxRPJJ7tD6AAQH9W4Y5rY9/U
 ylg6UVQIMmPtdLBxOBkJqeMgqG4MgRH9K7jVIcf1GV797xJ8DokuMH0d+VLTd7M1uWpuCU5Kg
 Wrc+Z5ASLm9KTk4wu/kH3En84wjCxKX6+OuYY1ycTTwYg3rDm/Pk48l8v62qnXb/dN4yyN/1F
 ZRUMRiilYKLkhk3LfmtueZw1XKXnptWtmlNFFjsq5W0SG6agNuU7kkB7Z/u9946IkSVJly3IK
 ptzj3SCIzT8DtiHyU7g3xv+HWa+epkSntSIXrnoCtBvoqAeXT56YhsqGYhrs+fQIgnPNZGdv/
 ifu657/S053UxPZQLUN9OfemvAQHyyMUaQtdJdL3s/sufl4j2SkqWy059LCxT3mP/LgAQgm/h
 otEwViu1hURGkDMDEmFvJVInzbT2TQSHoL0dE6A90P7zA0v/FtVrEMMYjl9mfbpvo2wKkUk/p
 zZRo85lkjXVtVfC5MxUAXjPJ4XAAoGej70WNF3PIu44XKqeavde4JIAirZioF+MLKPYWG4xg+
 tYA+0f4jljsn6aXooIedsOmGymr2tMHmaTXM/KZ8wXIEaOMYt+5LpsNAsF0NzDKfdwtNux3F/
 gr9+AhATIiPrkQtlY3Hth8yhwZxgOkqyLrq1fh24c1XQvOxRNxRMfX+ijPbYM5QEjh9S9z/Z5
 aWewm+nmPmXKr1J1d0GpDcTlFvvYeM5YOyiYVLLJR1A2o0CijA3C8FgrVdyh5vi4m51NrNrE3
 FzC1FvYI+EYjfOjA/55mvWjRnWtPSrdPPRWHtDwi4k6v9xP19TFxuO5A4FQUnJtcaYz/qX5oS
 oxAiHgSoQULxHkUbMXId6QRZGnMQPqNNq7o6MVRcwGvJSIYwaRWSCBg+tX6PK8asFutcfwhoD
 G8fLw8KdV0XEoOY4htPDTMKkJ4F4dJwj5xRflpw5GdjEabT/LDKXl+3CxQASIWaxjMQS+kFpF
 FYo5hlNEGjaoWwN3q
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> To fix this race, the spinlock cache->lock is used to protect the
> access to cache->cached in btrfs_block_group_done().

How do you think about to replace this wording by a variant like the follo=
wing?

   Thus use the spin lock =E2=80=9Ccache->lock=E2=80=9D to protect the acc=
ess to
   the data structure member =E2=80=9Ccached=E2=80=9D in the implementatio=
n of
   the function =E2=80=9Cbtrfs_block_group_done=E2=80=9D.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change descri=
ption?

Regards,
Markus
