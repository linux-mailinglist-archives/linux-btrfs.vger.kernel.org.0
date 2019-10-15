Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9138AD7F84
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJOTDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 15:03:12 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39416 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfJOTDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 15:03:11 -0400
Received: by mail-wm1-f42.google.com with SMTP id v17so195589wml.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qmBp+m+aav6lcpigfv7QSHsXYy1n0VU6hax7KWePsSc=;
        b=mvTlmY0GmQQtTSgJtGUYO6hls+Ax5a33Dj1KeNyiGUXyckhlftsUHRa8EK25YzpO7m
         x/9RB/mn2G/CblWLOm7mIfwW0gEO945bEdNFjwcVxy/5ZAx1wfWR38dvIoTERlcgP/NP
         mgkNsX3f8sw+a6rlNikisY3B9EJ1HgZg/mv+CKyh4SuWOCSkWR37AzahaMpVsLl1lUdI
         rNwVZu8iC8VLnOMZSMN7bazyEg1DNX3LepdKKn9eMOVdrQLFidKePTH2qQiiUf7ePGKy
         CKps+f440FwGS3N9wD3iFsP28+gPDtHCKSCd8C9VEPGnaptMPlbJNsqwvQn1c/ZLxTmt
         PIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=qmBp+m+aav6lcpigfv7QSHsXYy1n0VU6hax7KWePsSc=;
        b=R/stv/C128emCH+PqqZRrj5HkIOxQonsaKYbwonKX78goXfHjsYCGGwBtvVPkJ3MPY
         LlsD+L8pS2a8+WXodOhcbiXQe6p4C+x4GUlILb6Ol6iB+tZz3zDjbA4sBf+OtTGFbEqF
         ey7DTYubzlXmHlq8Fackz1VsiSzXdVibHvePbe9hp7PcDkFqC1V+DeVzSE2TFpEolLdO
         NQZMjopYMqUj5oPvKNmaxQLYKVdVqEe29H8UD8hQGjIQ+LQtPTf5vnEOqzU+7Mn223TE
         WInihIE4HhTUKy7OG2hw8RU9PygGBJ19Xqc6uzQL5olKFZSda+Z8WFdDOP1z39a1ALW+
         sFbA==
X-Gm-Message-State: APjAAAUoiAusLrnrBlkK0fa5GkJCcEEca/oHPTEQ/utXiddqQYj6zi4i
        M1R5uq/14oAUJ9KduUYkPDOIH4L3L5s=
X-Google-Smtp-Source: APXvYqwOHCBPuQNPEx98p/cxHR0OXbrd8Ydj7mHkYM6LCHDYOZvaA+b/YZKAen9cSB8GJUi895dfIw==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr38759wmg.89.1571166187857;
        Tue, 15 Oct 2019 12:03:07 -0700 (PDT)
Received: from argo.dxprod.sympato.ch (bsse-bs-dock-128-90.ethz.ch. [129.132.128.90])
        by smtp.googlemail.com with ESMTPSA id z189sm201514wmc.25.2019.10.15.12.03.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:03:05 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   DrYak <doktor.yak@gmail.com>
Subject: bad tree block start, want #### have 0
Autocrypt: addr=doktor.yak@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFZQDsABEAC5bXRJ37OpqYLjlXBZ5356OrUpHDY5rnkVRkfdvne6DBtI3qqjtZWkAoz5
 UE3LLs6bsWKIg/g1ApvlhpgflTl2dTTW2fJhhrMy2drnOYq2xB2mqyx+Kz8UBE08tR1BFc+I
 OKyr5O0yFWScfouFVvwNLO1etLslNxtWZxF860IzLL5V3ZOsy2dpWH9e9sir+Na272iOJxZX
 H9NgVZTsn7rEHkyVqNtdEyndGRqcpjMBm2Iuucvnq0QSrs4bvcEG3TJQSc48sVlJrS1qM/yq
 B+I30aGBFKKmw0cTBxpiWXJ5xYoOtFkzGOnMhVS8xTiE/1BTzJOAwBTK85KUu/8HIZ/+Nzjx
 OLd/BeDgfkTjjTjYW+IRivouI0tSHSEO1aEyVu2fBelgWHlV0Xsc2bZKQ5wwEkaUXwZJJUT5
 kC7muVBfj8fMoYXjW1XT+IP7x9kDC8BFANrr3x2E58NOBlTNmNaeoVFUwtQYBhypHqXC6sdM
 9LbU+hhKcPbWWf8il02bnkMVlwZpQSwRMCHIqAtF/CmbEWRnVgMztP5bT2klhVHFE6BrTEhG
 RftyYOstJLILNIosxXnikckpRXBk9gK0rr6cPVHUz6iGYmh0roL5+ZW55xuKKz7Mno2WUbz5
 yfg6aXb/nnZW5qFV+YwawVS7RAfl0GOMUMWMMsfOQS6jk4CAfQARAQABtCRJdmFuIFRvcG9s
 c2t5IDxkb2t0b3IueWFrQGdtYWlsLmNvbT6JAjkEEwECACMFAlZQDsACGy8HCwkIBwMCAQYV
 CAIJCgsEFgIDAQIeAQIXgAAKCRDt/cWlouzxQrugD/0fnPYVjp7lwWqsOJP1WmSMz81F3UNl
 ogLIJyDiFpoeKYeHs6us69Z7cbXi99AWTGg/KESRrOJwjkQvKzU0mM9QVC5m1utuv6PxOH5u
 fjGYQKnpvUkadHdI4qNcWiN9zRrHwe2wFPJmAgT/UaNy7v89K6lNJYLyOEr1rpmhAkhW9fwZ
 oezsQ7vgpf/27LvsLZpHXPgsatl7bqrPq7opUOybx1EyRPZz94B2fwvy0kSB5OUnKaneIoBJ
 YuMIatVUFAZ23oVx47OOlP2+ioC903OCz7DO5EMwvWTJ7UEraxTsBHIrf9kS9CqVUoG56ZTx
 DE44heHFPuWMD3b5UwexfcMqZ0J0YS8mqLdxNIOlMrDWgTsr7F/ZWyqlxzaRd8BXbBLEV/30
 vDcindKB0IueaoKkRuWdF2o6bf0v6ldcMWGkWrMMoBq3dezVHNzCFELLibz80TYS2pw8zFs2
 QwiAMZX5AaQOq3ea9lflf4kfKFh/izBd9T4mABBSTH8roR6rRPixgQqwQpx4CVq28FIj05cA
 yjCevPqiYFLCZ9te5pc9IrSCuOlM13rD5Jk/A4HJMJMdKPDSsnVrh8166yla4n8d5w9tsGrk
 n5xX5FwQs54tOSK0PtvEDz6iDeesH6FFXos+rfRm/j69VRYeQc8xH31DlFUuBz/zfs/TlJ/G
 78q24LkCDQRWUA7AARAAq4Fzh0BeaLuJa9uJrLtybT8C22m1KYCURITcVMY4wPs8E6MqwdqX
 kXx4zklVffctJgRML17DlUWSx/Ld+O+Z0oBJ7l6lwCpoTVzYE/Ye1JqdxFzvTjYdTI3LQyk8
 DnDZUZDD8ZwnWjZsL4vhcp/J3xoMT8c+VEW7l/2Co67S755jO3CvxnS5RfZB0CbfeHEuZCbX
 5nJMX9rb7IFVHyd2OVB7m1IQcXSKFs37vBz4o4LPTMGNf8ODdypWDsIw/rpBVx49ZGBm42Mg
 pSk/WVNbN+f3nvR/tuN8UWaAsNVarYDAn8vbcZt5xjah5y8r459Ao7d1ireFPnlnIswZ5hDg
 NpC30tQicPbnW7JA30retWGrevSKB9eVXxBUsBjplBZSyGx94OeRDaq19kt0TurPSNYEXnpu
 myUrWroEU1iiz6/FfS9mokSTS9oolN+P1BtZzSzpShQT72fKC3xaA3vhTIXDQDbXT7K4bFF9
 gM2vrjtBRSZ8sOyPB4hfRAXh0ErrID4Yt+X44vPAe4+lTrWoi7apiaf1V1YMijNwW6vH9u5M
 ffAgfg4nmWSHg88TqzUzJHO/lWAfKXKqbXQvNqLvLo/5beDkw1LHxIlDoxXolR334b8SUNgZ
 mFa6BQgsdzStGID0J5mD6OAitNFBVnoaH2Ar8viCiJXg8gJvlDrGUV0AEQEAAYkEPgQYAQIA
 CQUCVlAOwAIbLgIpCRDt/cWlouzxQsFdIAQZAQIABgUCVlAOwAAKCRDC+mrU1rs74/JtD/4z
 NJM1GeSTCf9NlG96CjdMaw9Ndbccqos1FKUuWOM/w/AOXi+J+o1DxyKRyoZEKEFOjEOx8ky/
 VBXs9ssdj4MpBJH5EDUTLz1fBD8t7xDaJv+uenOQyOr9JoMkql2ucfunmS6eUUUhmgOSxvBF
 uvfWMjOofrPCQV1oX2056Ku17Oz6JYBVjFdL5yn7JBhloJPhiK2/qFpp5AmH50Wp8fwW8SnM
 7gQliDRj2kSdGxs930XmiNdx+zvDpw/16xfMVIJ8qquSv9EGLuBZipJ6No1vMfGoSrmbXC6K
 EDM+/26cXg/LQdkn+MRt5oIoEp8Gd7trY2lH0yLZJmbGNrrhUkOehkc57rvOqFaDbZAipLWB
 L1o9lIjs8rouHhBqQPX/sHCjocxJR9KQ1dqjnqaBpK4IySD7FtstuRbvsUPegzSxrQ2lZrNz
 uq5e3DSRmfLoNh0JRVetRoujlY438qQ5XVKrzg3RrQ2M/EGjL28Hh7FCMemof9SoHzOxNss6
 Mbnvx9k7AV6Kvu1ofq2B+A2U6lxCnwCajvOmLLAQV2wzLi5EhLhFxftzySG2N5rakN5Ehro9
 Ups6lGMNmMpu8X4S7sm5OK4ZXx3ayXxRVx6Mb7x2YC0sMYj5SWqKhDOs2i/OfB1OUctkEw7o
 5cZGNkCd3RIDo8T1hFOwLEXnmw2O+UFeU67mEAC3SOM+4yGxK9yWmyO9ThZOUoCmHJZFMoqL
 pgdQJIijWwiAj4i8Z+lc7CZUVjALVTLPdIJqpdko+R2AccFWjZ+NdwCRNfGuSkwDXuw0Q15F
 jV1Sd7p+n0D67UAztA1FWOY1nbHmKSaRYvLLgFv6MCgERJlI02hIs1NyIaw3gkIW8R8FtRT5
 TovhD/RVVmQHbaEa2GOsiaJNBSojPn5UJfoG8fDRwRWtDKaiOVAkTvdQlRnUXH03co1OMvdm
 2/M7PZeuEnyadiNfAsi4yLbAY4LOeao2mJzCwVxi/gDhSPRaDOOjGWUxpFvtdDAT7pAzZJ0c
 njumANH3WmlOMpgS68o9ULZbBzVDq7NiR2DNLTMueFLJX9Ny5dh29MRajeSFKn24qR8blscA
 9xIeDtcrAQyouIlm/qrNJ4286BC5dIZgz44PrAKxGr8rYm4WjGNydMJuPal++S0XvWeWZ2lo
 SPFY43XEEd2GnaqObxX+TI9bYxD6xghL/oAsS/JuXSqbANKRYaildITFi/MFq7gWZpJ5OcAD
 cO9cNrWBh9cK3cTgSAGtnPtMTzaf+zW+Be1otnlXsw5N9ENVYfRrPSR4sO9Y4Cef6z5uXY27
 CmYGwHSpiHIQr2/6pbft7PE8LfTeNWnooq7szSpctacY2BVxe9OVYJAlxTzRQXU8Zhag233P Nw==
Message-ID: <3bd5b254-f3e4-1b81-da75-7a15cd49fc43@gmail.com>
Date:   Tue, 15 Oct 2019 21:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello

I'm having trouble on a BTRFS file system that I use on a Raspberry Pi.
I can still mount and access (nearly all) my data.

The trouble origin itself is probably hardware (flacky USB3-to-mSATA
adapter and/or power stability), not necessarily a bug in BTRFS.

As I've said I can retreive nearly all the data I need, so I could
surely just `btrfs restore` and then rebuild a new filesystem.

BUT...

I wanted to know if it would possible to just repair the filesystem.
(Basically kill the broken extent and/or excise the corresponding tree
leaf).

Are there any way ?

(Again it's not critical, I could btrfs-restore, I just want to know if
it would be possible to clean it instead).



Here are `journalctl` message regarding the failure:

Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): enabling
auto defrag
Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): enabling ssd
optimizations
Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): disk space
caching is enabled
Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): has skinny
extents
Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 126, gen 0
Oct 15 20:37:49 marsberry kernel: BTRFS error (device sdb1): bad tree
block start, want 547248750592 have 0
Oct 15 20:37:49 marsberry kernel: BTRFS error (device sdb1): bad tree
block start, want 547248750592 have 0



And here's the read-only check output:

# btrfs check /dev/sdb1
Opening filesystem to check...
Checking filesystem on /dev/sdb1
UUID: 5475b0ac-0010-4875-a0d6-e6641c951f5c
[1/7] checking root items
[2/7] checking extents
checksum verify failed on 547248750592 found E4E3BDB6 wanted 00000000
checksum verify failed on 547248750592 found E4E3BDB6 wanted 00000000
bad tree block 547248750592, bytenr mismatch, want=547248750592, have=0
checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
bad tree block 547248766976, bytenr mismatch, want=547248766976, have=0
owner ref check failed [547248750592 16384]
owner ref check failed [547248766976 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
bad tree block 547248766976, bytenr mismatch, want=547248766976, have=0
Error going to next leaf -5
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 247339167744 bytes used, error(s) found
total csum bytes: 241066812
total tree bytes: 434569216
total fs tree bytes: 169771008
total extent tree bytes: 16039936
btree space waste bytes: 42891494
file data blocks allocated: 270783406080
 referenced 268366499840



So any way to remove the damnaged data instead of restore/re-mkfs the
still non-damaged one ?

Thanks you!

