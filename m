Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3F5533DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350073AbiFUNkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiFUNkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 09:40:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDEB6E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:40:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w6so5976503pfw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:references:subject
         :content-language:from:in-reply-to;
        bh=zgC5SFtHEtBnNBega3se1zAvYCeYOf9JKjK3lMb+hHI=;
        b=UJ4IPkKAbMCh9jSrCQaIGrZ+Y/3c0VvxQ3uwJyFYfgQpc4Y33AuaanYuIkgepInVyP
         Ag8t4JZx1EAUPCkEePpdISKjEHAfV9L1HTT95tAdjhkVK0wd4fbvrtReUdcl0FzWUAwa
         yLLDgap/NvhFaTg67YNSNHzfySvBR+ReW7WRijvTPtxD4W+8LsG5GiNprJ12EFNsN0rx
         HH+EZiO6OS5CKZfdlX135YT/2LW6Ubw/MNMKAYc64dejjqxa6/4mIwhxZmRpnqhGfNJt
         khsP2okoNBFyxiP/ETSxWZqbUoU+lBKeFJc6fL4tXwpgman/JcLbNIKppMuf+OYam4aZ
         c3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :references:subject:content-language:from:in-reply-to;
        bh=zgC5SFtHEtBnNBega3se1zAvYCeYOf9JKjK3lMb+hHI=;
        b=cndo9HSyru3H9DT3hmWAWuPa3jpIoNqgIdo9fcUC74W0Gu4Q3gbjk2C7MURB4Ct0T1
         lsvzLVJQQ4QJvFYmjkxe0APXn743hPwhdiztTMYpQNb++17Oou+7RWfogSVJlY0NMs34
         9a4SrPZUErnUm0ky/hajbz3K9UyWpmmdJgdvklqDYKj8JQbYCExTHYpVTUZ/U8sshdFX
         U8lbBejGIF+9xRlYJ3xKzT5D++xbfjdvWH0oJ6ER2a0CelatXeBaYbjdGb/jgNvn8zyH
         I2LPaEe4WU1duc2XxDpkDdNQPI+DKSqVTvM9yth0WLWC0A0HdCzgqujuBxYT2PNxlxz+
         /sSA==
X-Gm-Message-State: AJIora/eZ8m3d3OYl7IkRBXwdMcQOu2lbwIiHnQlgMywxBMfGxt5WgzN
        tVSUtWJ0zT5fOahXJkgx/hIPYh7tHtw=
X-Google-Smtp-Source: AGRyM1sS/Swbzu9rgK96EprQuLkyAMRgsdEblYnCOy8fk0+QU17cz39IRwxSyQB6H2afni+0QmE9gw==
X-Received: by 2002:aa7:9206:0:b0:525:1068:c026 with SMTP id 6-20020aa79206000000b005251068c026mr17347285pfo.52.1655818849413;
        Tue, 21 Jun 2022 06:40:49 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id w26-20020a62c71a000000b0051bbd79fc9csm11257540pfg.57.2022.06.21.06.40.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:40:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------bdr7BarR5715Td8e6QQsyWYp"
Message-ID: <5e2b82d5-8129-747c-6447-808729e1f0c3@gmail.com>
Date:   Tue, 21 Jun 2022 22:40:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     linux-btrfs@vger.kernel.org
References: <f5cc6c6f-2238-b126-3b0e-00e9e49b0706@gmail.com>
Subject: Re: [IDEA RFC] Forward error correction (FEC) / Error correction code
 (ECC) for BTRFS
Content-Language: en-US
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <f5cc6c6f-2238-b126-3b0e-00e9e49b0706@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------bdr7BarR5715Td8e6QQsyWYp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here are runnable example programs of first two approaches.

Best Regards,
Zhang Boyang
--------------bdr7BarR5715Td8e6QQsyWYp
Content-Type: text/x-csrc; charset=UTF-8; name="1.c"
Content-Disposition: attachment; filename="1.c"
Content-Transfer-Encoding: base64

Ly8gZ2NjIC1PMiAtV2FsbCAxLmMgLWxzc2wgLWxjcnlwdG8gJiYgLi9hLm91dAoKI2luY2x1
ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGFzc2VydC5oPgoj
aW5jbHVkZSA8b3BlbnNzbC9ldnAuaD4KCnZvaWQgZGlnZXN0KHZvaWQgKm91dCwgc2l6ZV90
IG91dF9sZW4sIHZvaWQgKmluLCBzaXplX3QgaW5fbGVuKQp7CiAgICB1bnNpZ25lZCBjaGFy
IG1kX3ZhbHVlW0VWUF9NQVhfTURfU0laRV07CiAgICBFVlBfTURfQ1RYICptZGN0eDsKICAg
IGNvbnN0IEVWUF9NRCAqbWQgPSBFVlBfYmxha2UyYjUxMigpOwogICAgbWRjdHggPSBFVlBf
TURfQ1RYX25ldygpOwogICAgRVZQX0RpZ2VzdEluaXRfZXgobWRjdHgsIG1kLCBOVUxMKTsK
ICAgIEVWUF9EaWdlc3RVcGRhdGUobWRjdHgsIGluLCBpbl9sZW4pOwogICAgRVZQX0RpZ2Vz
dEZpbmFsX2V4KG1kY3R4LCBtZF92YWx1ZSwgTlVMTCk7CiAgICBFVlBfTURfQ1RYX2ZyZWUo
bWRjdHgpOwogICAgbWVtY3B5KG91dCwgbWRfdmFsdWUsIG91dF9sZW4pOwp9Cgp2b2lkIGhl
eGR1bXAodm9pZCAqcCwgc2l6ZV90IG4pCnsKICAgIHVuc2lnbmVkIGNoYXIgKnVjID0gcDsK
ICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbjsgaSsrKQogICAgICAgIHByaW50ZigiJTAy
eCIsIHVjW2ldKTsKfQoKI2RlZmluZSBGQUlMIDAKI2RlZmluZSBTVUNDRVNTIDEKCi8vLy8v
Ly8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8v
Ly8vLy8vLy8vLy8vLy8vLwoKI2RlZmluZSBOIDQwOTYKCnZvaWQgY2hlY2tzdW0odm9pZCAq
b3V0LCB2b2lkICppbikKewogICAgZGlnZXN0KG91dCwgMzIsIGluLCBOKTsKfQoKY2hhciBk
YXRhW05dOyAgLy8gZGF0YSBvbiBkaXNrLCBhc3N1bWUgb25seSBvbmUgYnl0ZSBpbiBpdCBp
cyBjb3JydXB0ZWQKY2hhciBjc3VtWzMyXTsgLy8gY2hlY2tzdW0gaW4gY3RyZWUKaW50IHJl
cGFpcigpCnsKICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTjsgaSsrKSAvLyBicnV0ZS1mb3Jj
ZSBlcnJvciBsb2NhdGlvbgogICAgICBmb3IgKGludCBqID0gMDsgaiA8IDB4MTAwOyBqKysp
IHsgLy8gYnJ1dGUtZm9yY2UgYnl0ZSB2YWx1ZSBhdCBsb2NhdGlvbiBpCiAgICAgICAgY2hh
ciBidWZbTl07CiAgICAgICAgbWVtY3B5KGJ1ZiwgZGF0YSwgTik7CiAgICAgICAgYnVmW2ld
ID0gajsKICAgICAgICBjaGFyIG5ld19jc3VtWzMyXTsKICAgICAgICBjaGVja3N1bShuZXdf
Y3N1bSwgYnVmKTsKICAgICAgICBpZiAobWVtY21wKGNzdW0sIG5ld19jc3VtLCAzMikgPT0g
MCkgewogICAgICAgICAgbWVtY3B5KGRhdGEsIGJ1ZiwgTik7CiAgICAgICAgICByZXR1cm4g
U1VDQ0VTUzsgLy8gZGF0YSBpbiBidWZbXSBhcmUgZ29vZCBkYXRhLCByZXBhaXIgc3VjY2Vl
ZGVkCiAgICAgICAgfQogICAgICB9CiAgICByZXR1cm4gRkFJTDsgLy8gc2VhcmNoIHNwYWNl
IGV4aGF1c3RlZCwgZmFpbGVkIHRvIHJlcGFpcgp9CgppbnQgbWFpbigpCnsKICAgIC8vIGdl
dCByYW5kb20gZGF0YQogICAgRklMRSAqZnAgPSBmb3BlbigiL2Rldi91cmFuZG9tIiwgInIi
KTsKICAgIGFzc2VydChmcCk7CiAgICBmcmVhZChkYXRhLCAxLCBOLCBmcCk7CiAgICBmY2xv
c2UoZnApOwoKICAgIC8vIGNhbGMgY2hlY2tzdW0gb2YgZ29vZCBkYXRhCiAgICBjaGVja3N1
bShjc3VtLCBkYXRhKTsKICAgIHByaW50ZigiZ29vZFx0Iik7IGhleGR1bXAoY3N1bSwgMzIp
OyBwcmludGYoIlxuIik7CgogICAgLy8gY29ycnVwdCBzb21lIGRhdGEKICAgIGRhdGFbTi0x
XSA9IDIwMDsKICAgIC8vZGF0YVsxMDFdID0gMjAwOwoKICAgIC8vIGNhbGMgY2hlY2tzdW0g
b2YgYmFkIGRhdGEKICAgIGNoYXIgYmFkX2NzdW1bMzJdOwogICAgY2hlY2tzdW0oYmFkX2Nz
dW0sIGRhdGEpOwogICAgcHJpbnRmKCJiYWRcdCIpOyBoZXhkdW1wKGJhZF9jc3VtLCAzMik7
IHByaW50ZigiXG4iKTsKCiAgICAvLyB0cnkgcmVwYWlyCiAgICBpbnQgcmVzdWx0ID0gcmVw
YWlyKCk7CiAgICBwcmludGYoIiVzXHQiLCByZXN1bHQgPyAiU1VDQ0VTUyIgOiAiRkFJTCIp
OwogICAgY2hhciByZXBhaXJfY3N1bVszMl07CiAgICBjaGVja3N1bShyZXBhaXJfY3N1bSwg
ZGF0YSk7CiAgICBoZXhkdW1wKHJlcGFpcl9jc3VtLCAzMik7IHByaW50ZigiXG4iKTsKCiAg
ICByZXR1cm4gMDsKfQo=
--------------bdr7BarR5715Td8e6QQsyWYp
Content-Type: text/x-csrc; charset=UTF-8; name="2.c"
Content-Disposition: attachment; filename="2.c"
Content-Transfer-Encoding: base64

Ly8gZ2NjIC1PMiAtV2FsbCAyLmMgLWxzc2wgLWxjcnlwdG8gJiYgLi9hLm91dAoKI2luY2x1
ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGFzc2VydC5oPgoj
aW5jbHVkZSA8b3BlbnNzbC9ldnAuaD4KCnZvaWQgZGlnZXN0KHZvaWQgKm91dCwgc2l6ZV90
IG91dF9sZW4sIHZvaWQgKmluLCBzaXplX3QgaW5fbGVuKQp7CiAgICB1bnNpZ25lZCBjaGFy
IG1kX3ZhbHVlW0VWUF9NQVhfTURfU0laRV07CiAgICBFVlBfTURfQ1RYICptZGN0eDsKICAg
IGNvbnN0IEVWUF9NRCAqbWQgPSBFVlBfYmxha2UyYjUxMigpOwogICAgbWRjdHggPSBFVlBf
TURfQ1RYX25ldygpOwogICAgRVZQX0RpZ2VzdEluaXRfZXgobWRjdHgsIG1kLCBOVUxMKTsK
ICAgIEVWUF9EaWdlc3RVcGRhdGUobWRjdHgsIGluLCBpbl9sZW4pOwogICAgRVZQX0RpZ2Vz
dEZpbmFsX2V4KG1kY3R4LCBtZF92YWx1ZSwgTlVMTCk7CiAgICBFVlBfTURfQ1RYX2ZyZWUo
bWRjdHgpOwogICAgbWVtY3B5KG91dCwgbWRfdmFsdWUsIG91dF9sZW4pOwp9Cgp2b2lkIGhl
eGR1bXAodm9pZCAqcCwgc2l6ZV90IG4pCnsKICAgIHVuc2lnbmVkIGNoYXIgKnVjID0gcDsK
ICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbjsgaSsrKQogICAgICAgIHByaW50ZigiJTAy
eCIsIHVjW2ldKTsKfQoKI2RlZmluZSBGQUlMIDAKI2RlZmluZSBTVUNDRVNTIDEKCi8vLy8v
Ly8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8vLy8v
Ly8vLy8vLy8vLy8vLy8vLwoKI2RlZmluZSBOIDQwOTYKI2RlZmluZSBUIDgKCnZvaWQgY2hl
Y2tzdW0odm9pZCAqb3V0LCB2b2lkICppbikKewogICAgY2hhciAqeHYgPSAoY2hhciAqKW91
dCArIDMyIC0gVDsKICAgIG1lbXNldCh4diwgMCwgVCk7CiAgICBmb3IgKGludCBpID0gMDsg
aSA8IE47IGkrKykKICAgICAgeHZbaSAlIFRdIF49ICgoY2hhciAqKWluKVtpXTsKICAgIGRp
Z2VzdChvdXQsIDMyIC0gVCwgaW4sIE4pOwp9CgpjaGFyIGRhdGFbTl07ICAvLyBkYXRhIG9u
IGRpc2ssIGFzc3VtZSBhdCBtb3N0IFQgY29uc2VjdXRpdmUgYmFkIGJ5dGVzCmNoYXIgY3N1
bVszMl07IC8vIGNoZWNrc3VtIGluIGN0cmVlLCAzMi1UIGJ5dGVzIGhhc2ggYW5kIFQgYnl0
ZXMgeHZbXQppbnQgcmVwYWlyKCkKewogICAgY2hhciAqeHYgPSBjc3VtICsgMzIgLSBUOwog
ICAgZm9yIChpbnQgaSA9IDA7IGkgPD0gTiAtIFQ7IGkrKykgeyAvLyBicnV0ZS1mb3JjZSB0
aGUgYmVnaW4gb2YgZXJyb3IgbG9jYXRpb24KICAgICAgY2hhciBidWZbTl07CiAgICAgIG1l
bWNweShidWYsIGRhdGEsIE4pOwoKICAgICAgLy8gY2FsY3VsYXRlIHZhbHVlcyBpbiBlcnJv
ciBsb2NhdGlvbiB1c2luZyB4dltdCiAgICAgIGNoYXIgcmVwYWlyW1RdOwogICAgICBtZW1j
cHkocmVwYWlyLCB4diwgVCk7CiAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgTjsgaisrKQog
ICAgICAgIGlmIChqIDwgaSB8fCBqID49IGkgKyBUKQogICAgICAgICAgcmVwYWlyW2ogJSBU
XSBePSBidWZbal07CiAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgVDsgaisrKQogICAgICAg
IGJ1ZltpICsgal0gPSByZXBhaXJbKGkgKyBqKSAlIFRdOwoKICAgICAgY2hhciBuZXdfY3N1
bVszMl07CiAgICAgIGNoZWNrc3VtKG5ld19jc3VtLCBidWYpOwogICAgICBpZiAobWVtY21w
KGNzdW0sIG5ld19jc3VtLCAzMiAtIFQpID09IDApIHsKICAgICAgICBtZW1jcHkoZGF0YSwg
YnVmLCBOKTsKICAgICAgICByZXR1cm4gU1VDQ0VTUzsgLy8gZGF0YSBpbiBidWZbXSBhcmUg
Z29vZCBkYXRhLCByZXBhaXIgc3VjY2VlZGVkCiAgICAgIH0KICAgIH0KICAgIHJldHVybiBG
QUlMOyAvLyBzZWFyY2ggc3BhY2UgZXhoYXVzdGVkLCBmYWlsZWQgdG8gcmVwYWlyCn0KCmlu
dCBtYWluKCkKewogICAgLy8gZ2V0IHJhbmRvbSBkYXRhCiAgICBGSUxFICpmcCA9IGZvcGVu
KCIvZGV2L3VyYW5kb20iLCAiciIpOwogICAgYXNzZXJ0KGZwKTsKICAgIGZyZWFkKGRhdGEs
IDEsIE4sIGZwKTsKICAgIGZjbG9zZShmcCk7CgogICAgLy8gY2FsYyBjaGVja3N1bSBvZiBn
b29kIGRhdGEKICAgIGNoZWNrc3VtKGNzdW0sIGRhdGEpOwogICAgcHJpbnRmKCJnb29kXHQi
KTsgaGV4ZHVtcChjc3VtLCAzMik7IHByaW50ZigiXG4iKTsKCiAgICAvLyBjb3JydXB0IHNv
bWUgZGF0YQogICAgZGF0YVtOLTFdID0gMjAwOwogICAgZGF0YVtOLThdID0gMjAwOwogICAg
Ly9kYXRhW04tOV0gPSAyMDA7CgogICAgLy8gY2FsYyBjaGVja3N1bSBvZiBiYWQgZGF0YQog
ICAgY2hhciBiYWRfY3N1bVszMl07CiAgICBjaGVja3N1bShiYWRfY3N1bSwgZGF0YSk7CiAg
ICBwcmludGYoImJhZFx0Iik7IGhleGR1bXAoYmFkX2NzdW0sIDMyKTsgcHJpbnRmKCJcbiIp
OwoKICAgIC8vIHRyeSByZXBhaXIKICAgIGludCByZXN1bHQgPSByZXBhaXIoKTsKICAgIHBy
aW50ZigiJXNcdCIsIHJlc3VsdCA/ICJTVUNDRVNTIiA6ICJGQUlMIik7CiAgICBjaGFyIHJl
cGFpcl9jc3VtWzMyXTsKICAgIGNoZWNrc3VtKHJlcGFpcl9jc3VtLCBkYXRhKTsKICAgIGhl
eGR1bXAocmVwYWlyX2NzdW0sIDMyKTsgcHJpbnRmKCJcbiIpOwoKICAgIHJldHVybiAwOwp9
Cg==

--------------bdr7BarR5715Td8e6QQsyWYp--
