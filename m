Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA64E7FA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 07:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiCZHAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Mar 2022 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiCZHAu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Mar 2022 03:00:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AAC58808
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 23:59:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d15so8266907qty.8
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:to:from:in-reply-to:content-transfer-encoding;
        bh=+V3bJx0Ba+REHMcDbNpt/YbSPVipnZdYcHZc15/AKPw=;
        b=NM558wqq3DCeTaPriyLZXNdZIWRDwa2Y3BfpTuTdE8LbUhz+6wOFYgeVf8jZRtdmnG
         7Z3Os4Sm8dPUr8Uveh3bQHrlF8+0jNRYNHhiBVtvPAPriQTXe1fVeNR0/fHiPiYkBFh0
         vL+ZwQreEME37bQMUO2c64Xaz/mUhHvFdy3yNdSsOMezrzTiVrY/GBbAdcpfq9GEGezs
         fOHrm0oLrpLAJV6KEhVtI6mbyfFGgSjYgOz3iQZfifitIyCGlvJD79o6aGtXPHsPjdUt
         Khxx/wKfLN4ZNZTulz8UfydnwaGVXS527jHN3Vx41djhMSlRcCKt24Kz6dJcdAu+optx
         yEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:to:from:in-reply-to
         :content-transfer-encoding;
        bh=+V3bJx0Ba+REHMcDbNpt/YbSPVipnZdYcHZc15/AKPw=;
        b=U3vp5//IZdyjpLhI9aSWHIP2/KvGCiTEl1slVh+hr3U6bvGzwTRKxe8Octcs5bhckR
         VRKZ3bTlSuGEuee+r5WBtnZwRYcW4wY+cbrHB2s16KpnZOtXU+DbXI3UE8peH6n22KtU
         ZLyoDiFrWo1n5xTh5f0MwI6nn9Y2Dbql3jm3eEhiga7wWftpWEOllIK0o1QWhPBoR+y5
         y7fIyK8R4vIe/oS6ohWa4Ieerhl8jj6LVITPk/+l2C4eplTNX7I2VQmGU8AB9sFa+2tY
         Py09cUn/uD1rFcP5rBONUTdnSHxR07/KXtkbgibhCyZuiyZq0CPQyfTJtVTTas9lyatE
         JSJw==
X-Gm-Message-State: AOAM531KqPBhtkuk31GUObzT6p4Rm3mp7hIPqzTsYwV3wiYStxOh2Hfs
        MV5coJi6gIdm6exSTaBCnBKqbrYSDt0=
X-Google-Smtp-Source: ABdhPJybAmb7iT280+YFuuFaootmGnmI4FE6HxAVJraoYgNc+EBWrwKgxYeRu9vMVztUXe+R4Oc2Dg==
X-Received: by 2002:a05:622a:1210:b0:2e1:f86d:b381 with SMTP id y16-20020a05622a121000b002e1f86db381mr12604609qtx.338.1648277952343;
        Fri, 25 Mar 2022 23:59:12 -0700 (PDT)
Received: from [192.168.69.254] (pool-72-69-225-179.nycmny.fios.verizon.net. [72.69.225.179])
        by smtp.gmail.com with ESMTPSA id d26-20020a05620a159a00b0067d4f5637d7sm4526332qkk.14.2022.03.25.23.59.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 23:59:11 -0700 (PDT)
Message-ID: <86173796-1a59-8d16-0152-ea32df21b4d7@gmail.com>
Date:   Sat, 26 Mar 2022 02:59:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0a1
Subject: Re: Error adding new device on paused balance filesystem
Content-Language: en-US
References: <12d90158-1722-6d82-32f7-b294810d7549@gmail.com>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Asif Youssuff <yoasif@gmail.com>
In-Reply-To: <12d90158-1722-6d82-32f7-b294810d7549@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TGlzdCwNCg0KSSByZWFsaXplZCB0aGF0IG15IG1lc3NhZ2UgZGlkbid0IGluY2x1ZGUgdGhl
IGVycm9yIG1lc3NhZ2UgKGl0IHdhcyBpbiANCnRoZSBhdHRhY2htZW50KS4gUGVyaGFwcyB0
aGlzIHdpbGwgaGVscDoNCg0KWyAxMTAwLjQwMjQ5MF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQpbIDExMDAuNDAyNTAwXSBCVFJGUzogVHJhbnNhY3Rpb24gYWJv
cnRlZCAoZXJyb3IgLTI4KQ0KWyAxMTAwLjQwMjU0OV0gQlRSRlM6IGVycm9yIChkZXZpY2Ug
c2RmKSBpbiBfX2J0cmZzX2ZyZWVfZXh0ZW50OjMwNzk6IGVycm5vPS0yOCBObyBzcGFjZSBs
ZWZ0DQpbIDExMDAuNDAyNTk1XSBXQVJOSU5HOiBDUFU6IDIgUElEOiAxMzIxOCBhdCBmcy9i
dHJmcy9leHRlbnQtdHJlZS5jOjMwNzkgX19idHJmc19mcmVlX2V4dGVudCsweDQ5Zi8weDlj
MCBbYnRyZnNdDQpbIDExMDAuNDAzNDI1XSBNb2R1bGVzIGxpbmtlZCBpbjogeGZzDQpbIDEx
MDAuNDAzNDI3XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RmKTogZm9yY2VkIHJlYWRvbmx5DQpb
IDExMDAuNDAzNDM0XSAgbmlsZnMyIHh0X21hcmsNClsgMTEwMC40MDM0MzldIEJUUkZTOiBl
cnJvciAoZGV2aWNlIHNkZikgaW4gYnRyZnNfcnVuX2RlbGF5ZWRfcmVmczoyMTU5OiBlcnJu
bz0tMjggTm8gc3BhY2UgbGVmdA0KWyAxMTAwLjQwMzQ0Ml0gIHh0X25hdCB2ZXRoIHh0X0NI
RUNLU1VNIGlwdGFibGVfbWFuZ2xlIGlwdF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjQgeHRfdGNw
dWRwIHh0X2Nvbm50cmFjayB4dF9NQVNRVUVSQURFIG5mX2Nvbm50cmFja19uZXRsaW5rIG5m
bmV0bGluayB4ZnJtX3VzZXIgeGZybV9hbGdvIHh0X2FkZHJ0eXBlIGlwdGFibGVfbmF0IG5m
X25hdCBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgYnJfbmV0
ZmlsdGVyIGJyaWRnZSBzdHAgbGxjIGVidGFibGVfZmlsdGVyIGVidGFibGVzIGlwNnRhYmxl
X2ZpbHRlciBpcDZfdGFibGVzIGlwdGFibGVfZmlsdGVyIHBwZGV2IHBhcnBvcnRfcGMgcGFy
cG9ydCB2bXdfdnNvY2tfdm1jaV90cmFuc3BvcnQgdnNvY2sgdm13X3ZtY2kgb3ZlcmxheSBq
b3lkZXYgaW5wdXRfbGVkcyBibHVldG9vdGggZWNkaF9nZW5lcmljIGVjYyBtc3IgYmluZm10
X21pc2MgaXBtaV9zc2lmIGludGVsX3JhcGxfbXNyIGludGVsX3JhcGxfY29tbW9uIHg4Nl9w
a2dfdGVtcF90aGVybWFsIGludGVsX3Bvd2VyY2xhbXAgZG1fY3J5cHQgY29yZXRlbXAga3Zt
X2ludGVsIGt2bSBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBnaGFzaF9jbG11bG5p
X2ludGVsIGFlc25pX2ludGVsIGNyeXB0b19zaW1kIGNyeXB0ZCByYXBsIGludGVsX2NzdGF0
ZSBpbnRlbF9wY2hfdGhlcm1hbCBscGNfaWNoIG1laV9tZSBtZWkgYWNwaV9pcG1pIGllMzEy
MDBfZWRhYyBpcG1pX3NpIGlwbWlfZGV2aW50ZiBpcG1pX21zZ2hhbmRsZXIgYWNwaV9wYWQg
bWFjX2hpZCBzY2hfZnFfY29kZWwgaWJfaXNlciByZG1hX2NtIGl3X2NtIGliX2NtIGliX2Nv
cmUgaXNjc2lfdGNwIGxpYmlzY3NpX3RjcCBsaWJpc2NzaSBzY3NpX3RyYW5zcG9ydF9pc2Nz
aSBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCBidHJmcyBibGFrZTJiX2dlbmVyaWMgenN0
ZF9jb21wcmVzcyByYWlkMTAgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNvdg0KWyAxMTAwLjQw
NDU4M10gIGFzeW5jX21lbWNweSBhc3luY19wcSBhc3luY194b3IgYXN5bmNfdHggeG9yIHJh
aWQ2X3BxIGxpYmNyYzMyYyByYWlkMSByYWlkMCBtdWx0aXBhdGggbGluZWFyIGhpZF9nZW5l
cmljIHVzYmhpZCBoaWQgdWFzIHVzYl9zdG9yYWdlIGFzdCBkcm1fdnJhbV9oZWxwZXIgZHJt
X3R0bV9oZWxwZXIgdHRtIGRybV9rbXNfaGVscGVyIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0
IHN5c2ltZ2JsdCBmYl9zeXNfZm9wcyBjZWMgbXB0M3NhcyBpZ2IgcmNfY29yZSByYWlkX2Ns
YXNzIGFoY2kgc2NzaV90cmFuc3BvcnRfc2FzIGRjYSBkcm0geGhjaV9wY2kgZTEwMDBlIGxp
YmFoY2kgaTJjX2FsZ29fYml0IHhoY2lfcGNpX3JlbmVzYXMgdmlkZW8NClsgMTEwMC40MDQ2
OThdIENQVTogMiBQSUQ6IDEzMjE4IENvbW06IGJ0cmZzLXRyYW5zYWN0aSBUYWludGVkOiBH
ICAgICAgICBXICAgICAgICAgNS4xNy4wLTA1MTcwMC1nZW5lcmljICMyMDIyMDMyMDIxMzAN
ClsgMTEwMC40MDQ3MDhdIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gWDEwU0xNLUYvWDEw
U0xNLUYsIEJJT1MgMy4wIDA0LzI0LzIwMTUNClsgMTEwMC40MDQ3MTNdIFJJUDogMDAxMDpf
X2J0cmZzX2ZyZWVfZXh0ZW50KzB4NDlmLzB4OWMwIFtidHJmc10NClsgMTEwMC40MDQ4NTld
IENvZGU6IGRmIGU4IDk1IDFjIGZmIGZmIDQ4IDhiIDQ1IDk4IDRjIDg5IDY1IGJmIGM2IDQ1
IGM3IGE4IDQ4IDg5IDQ1IGM4IGU5IGRkIGZkIGZmIGZmIDQ0IDg5IGVlIDQ4IGM3IGM3IGY4
IDRjIDk0IGMwIGU4IDY3IDU3IGU2IGYyIDwwZj4gMGIgNDggOGIgN2QgOTAgNDQgODkgZTkg
YmEgMDcgMGMgMDAgMDAgNDggYzcgYzYgNDAgOTMgOTMgYzAgZTgNClsgMTEwMC40MDQ4Njdd
IFJTUDogMDAxODpmZmZmYWUyNjAyMDZmYmU4IEVGTEFHUzogMDAwMTAyODINClsgMTEwMC40
MDQ4NzZdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5NzViMDBlY2ExNTAgUkNY
OiAwMDAwMDAwMDAwMDAwMDI3DQpbIDExMDAuNDA0ODgzXSBSRFg6IGZmZmY5NzYxN2ZjYTA5
ODggUlNJOiAwMDAwMDAwMDAwMDAwMDAxIFJESTogZmZmZjk3NjE3ZmNhMDk4MA0KWyAxMTAw
LjQwNDg4OV0gUkJQOiBmZmZmYWUyNjAyMDZmYzkwIFIwODogMDAwMDAwMDAwMDAwMDAwMyBS
MDk6IGZmZmZmZmZmZmZmZWU0ZDgNClsgMTEwMC40MDQ4OTRdIFIxMDogMDAwMDAwMDAwMGZm
ZmYwYSBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAxNTdmYzM0YmJlMDAwDQpbIDEx
MDAuNDA0OTAwXSBSMTM6IDAwMDAwMDAwZmZmZmZmZTQgUjE0OiAwMDAxNGM2N2I5YjljMDAw
IFIxNTogMDAwMDAwMDAwMDAwYzY4MA0KWyAxMTAwLjQwNDkwN10gRlM6ICAwMDAwMDAwMDAw
MDAwMDAwKDAwMDApIEdTOmZmZmY5NzYxN2ZjODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAw
MDAwMDAwMA0KWyAxMTAwLjQwNDkxNV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENS
MDogMDAwMDAwMDA4MDA1MDAzMw0KWyAxMTAwLjQwNDkyMl0gQ1IyOiAwMDAwN2Y0NWZmMzUy
OGE4IENSMzogMDAwMDAwMDIyZGUxMDAwMiBDUjQ6IDAwMDAwMDAwMDAxNzA2ZTANClsgMTEw
MC40MDQ5MjldIENhbGwgVHJhY2U6DQpbIDExMDAuNDA0OTM0XSAgPFRBU0s+DQpbIDExMDAu
NDA0OTQ3XSAgcnVuX2RlbGF5ZWRfZGF0YV9yZWYrMHg5My8weDE4MCBbYnRyZnNdDQpbIDEx
MDAuNDA1MDkxXSAgYnRyZnNfcnVuX2RlbGF5ZWRfcmVmc19mb3JfaGVhZCsweDE4NS8weDUw
MCBbYnRyZnNdDQpbIDExMDAuNDA1MjYzXSAgX19idHJmc19ydW5fZGVsYXllZF9yZWZzKzB4
OGMvMHgxZDAgW2J0cmZzXQ0KWyAxMTAwLjQwNTQyNV0gIGJ0cmZzX3J1bl9kZWxheWVkX3Jl
ZnMrMHg3My8weDFmMCBbYnRyZnNdDQpbIDExMDAuNDA1NTY4XSAgPyBrbWVtX2NhY2hlX2Fs
bG9jKzB4MWIzLzB4MzMwDQpbIDExMDAuNDA1NTg0XSAgYnRyZnNfY29tbWl0X3RyYW5zYWN0
aW9uKzB4NjMvMHhiNDAgW2J0cmZzXQ0KWyAxMTAwLjQwNTcyOF0gID8gc3RhcnRfdHJhbnNh
Y3Rpb24rMHhjYS8weDVkMCBbYnRyZnNdDQpbIDExMDAuNDA1ODcwXSAgPyB0cmFjZV9yYXdf
b3V0cHV0X3RpY2tfc3RvcCsweDYwLzB4NjANClsgMTEwMC40MDU4ODRdICB0cmFuc2FjdGlv
bl9rdGhyZWFkKzB4MTNlLzB4MWIwIFtidHJmc10NClsgMTEwMC40MDYwNDFdICA/IGJ0cmZz
X2NsZWFudXBfdHJhbnNhY3Rpb24uaXNyYS4wKzB4NTUwLzB4NTUwIFtidHJmc10NClsgMTEw
MC40MDYzMDJdICBrdGhyZWFkKzB4ZWUvMHgxMjANClsgMTEwMC40MDYzMjRdICA/IGt0aHJl
YWRfY29tcGxldGVfYW5kX2V4aXQrMHgyMC8weDIwDQpbIDExMDAuNDA2MzM4XSAgcmV0X2Zy
b21fZm9yaysweDIyLzB4MzANClsgMTEwMC40MDYzNTZdICA8L1RBU0s+DQpbIDExMDAuNDA2
MzYwXSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCg0KVGhhbmtzLA0K
QXNpZg0KDQpPbiAzLzIxLzIyIDQ6MzQgUE0sIEFzaWYgWW91c3N1ZmYgd3JvdGU6DQo+IEhp
IEJ0cmZzIG1haWxpbmcgbGlzdCwNCj4NCj4gSXQgd2FzIHdpdGggZ3JlYXQgZXhjaXRlbWVu
dCB0aGF0IEkgcmVhZCBvbiBrZXJuZWxuZXdiaWVzIHRoYXQgNS4xNyANCj4gYWxsb3dzIHBl
b3BsZSB0byBhZGQgbmV3IGRldmljZXMgd2hlbiBiYWxhbmNlIGlzIHBhdXNlZCAtIEkgdGhv
dWdodCBJIA0KPiB3b3VsZCBmaW5hbGx5IGJlIGFibGUgdG8gcmV2aXZlIGFuIGFycmF5IHRo
YXQgaGFzIGJlZW4gc3R1Y2sgaW4gdGltZSANCj4gZm9yIGEgd2hpbGUuDQo+DQo+IEkgcHJl
dmlvdXNseSBwb3N0ZWQgYWJvdXQgdGhpcyBhcnJheSBpbiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtYnRyZnMvMmJiODMyZGItM2MzMy1kM2JhLWQ5YWUtNGViZDQ0YzFj
N2YzQGdtYWlsLmNvbS8gDQo+IHdpdGggc3ViamVjdCAiRmlsZXN5c3RlbSBnb2VzIHJlYWRv
bmx5IHNvb24gYWZ0ZXIgbW91bnQsIGNhbm5vdCBmcmVlIA0KPiBzcGFjZSBvciByZWJhbGFu
Y2UgDQo+IDxodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy8yYmI4MzJkYi0z
YzMzLWQzYmEtZDlhZS00ZWJkNDRjMWM3ZjNAZ21haWwuY29tLyNyPiIuDQo+DQo+IFdoZW4g
SSB0cnkgdG8gYWRkIGEgbmV3IGRldmljZSBpbnRvIGEgcGF1c2VkIGJhbGFuY2UgZnMsIEkg
Z2V0Og0KPg0KPiBFUlJPUjogZXJyb3IgYWRkaW5nIGRldmljZSAnL2Rldi9zZGwnOiBObyBz
cGFjZSBsZWZ0IG9uIGRldmljZQ0KPg0KPiB1bmFtZSAtYQ0KPiBMaW51eCBidXR0ZXItc2Vy
dmVyIDUuMTcuMC0wNTE3MDAtZ2VuZXJpYyAjMjAyMjAzMjAyMTMwIFNNUCBQUkVFTVBUIA0K
PiBTdW4gTWFyIDIwIDIxOjMzOjQxIFVUQyAyMDIyIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdO
VS9MaW51eA0KPg0KPiBidHJmcyAtLXZlcnNpb24NCj4gYnRyZnMtcHJvZ3MgdjUuMTMuMQ0K
Pg0KPiBidHJmcyBmaSBzaG93DQo+IFtzdWRvXSBwYXNzd29yZCBmb3IgYXNpZjoNCj4gTGFi
ZWw6IG5vbmXCoCB1dWlkOiA0OGVkOGE2Ni03MzFkLTQ5OWItODI5ZS1kZDA3ZGQ3MjYwY2MN
Cj4gwqDCoMKgwqBUb3RhbCBkZXZpY2VzIDE0IEZTIGJ5dGVzIHVzZWQgNTAuNzlUaUINCj4g
wqDCoMKgwqBkZXZpZMKgwqDCoCA0IHNpemUgNS40NlRpQiB1c2VkIDUuNDZUaUIgcGF0aCAv
ZGV2L3NkZg0KPiDCoMKgwqDCoGRldmlkwqDCoMKgIDUgc2l6ZSA3LjI4VGlCIHVzZWQgNy4y
OFRpQiBwYXRoIC9kZXYvc2RqDQo+IMKgwqDCoMKgZGV2aWTCoMKgwqAgNyBzaXplIDEyLjcz
VGlCIHVzZWQgMTIuNzNUaUIgcGF0aCAvZGV2L3NkZw0KPiDCoMKgwqDCoGRldmlkwqDCoMKg
IDkgc2l6ZSA1LjQ2VGlCIHVzZWQgNS40NlRpQiBwYXRoIC9kZXYvc2RkDQo+IMKgwqDCoMKg
ZGV2aWTCoMKgIDEwIHNpemUgNy4yOFRpQiB1c2VkIDcuMjhUaUIgcGF0aCAvZGV2L3NkcQ0K
PiDCoMKgwqDCoGRldmlkwqDCoCAxMSBzaXplIDcuMjhUaUIgdXNlZCA3LjI4VGlCIHBhdGgg
L2Rldi9zZG0NCj4gwqDCoMKgwqBkZXZpZMKgwqAgMTIgc2l6ZSA1LjQ2VGlCIHVzZWQgNS40
NlRpQiBwYXRoIC9kZXYvc2RiDQo+IMKgwqDCoMKgZGV2aWTCoMKgIDE0IHNpemUgNy4yOFRp
QiB1c2VkIDcuMjhUaUIgcGF0aCAvZGV2L3NkYQ0KPiDCoMKgwqDCoGRldmlkwqDCoCAxNSBz
aXplIDcuMjhUaUIgdXNlZCA3LjI4VGlCIHBhdGggL2Rldi9zZG8NCj4gwqDCoMKgwqBkZXZp
ZMKgwqAgMTcgc2l6ZSA5LjEwVGlCIHVzZWQgNy40OVRpQiBwYXRoIC9kZXYvc2RlDQo+IMKg
wqDCoMKgZGV2aWTCoMKgIDE4IHNpemUgNy4yOFRpQiB1c2VkIDcuMjhUaUIgcGF0aCAvZGV2
L3Nkbg0KPiDCoMKgwqDCoGRldmlkwqDCoCAyMCBzaXplIDcuMjhUaUIgdXNlZCA3LjI4VGlC
IHBhdGggL2Rldi9zZGMNCj4gwqDCoMKgwqBkZXZpZMKgwqAgMjEgc2l6ZSA3LjI4VGlCIHVz
ZWQgNi40MlRpQiBwYXRoIC9kZXYvc2RwDQo+IMKgwqDCoMKgZGV2aWTCoMKgIDIyIHNpemUg
MjIzLjU3R2lCIHVzZWQgMS44OE1pQiBwYXRoIC9kZXYvc2RsDQo+DQo+IExhYmVsOiBub25l
wqAgdXVpZDogYzg1NTdhNmUtNGI1MS00NGYxLWJhOGYtNzVmY2U4YzdkZmNkDQo+IMKgwqDC
oMKgVG90YWwgZGV2aWNlcyAxIEZTIGJ5dGVzIHVzZWQgNS4zOFRpQg0KPiDCoMKgwqDCoGRl
dmlkwqDCoMKgIDEgc2l6ZSA1LjQ2VGlCIHVzZWQgNS40NlRpQiBwYXRoIC9kZXYvc2RoMQ0K
Pg0KPiBidHJmcyBmaSBkZiAvbWVkaWEvY2FtaW5vLw0KPiBEYXRhLCBSQUlEMTogdG90YWw9
MzcuNTlUaUIsIHVzZWQ9MzYuOThUaUINCj4gRGF0YSwgUkFJRDY6IHRvdGFsPTEzLjc3VGlC
LCB1c2VkPTEzLjc1VGlCDQo+IFN5c3RlbSwgUkFJRDFDNDogdG90YWw9MzIuMDBNaUIsIHVz
ZWQ9MTIuOTdNaUINCj4gTWV0YWRhdGEsIFJBSUQxQzQ6IHRvdGFsPTY2LjAwR2lCLCB1c2Vk
PTY1LjYyR2lCDQo+IEdsb2JhbFJlc2VydmUsIHNpbmdsZTogdG90YWw9NTEyLjAwTWlCLCB1
c2VkPTAuMDBCDQo+IFdBUk5JTkc6IE11bHRpcGxlIGJsb2NrIGdyb3VwIHByb2ZpbGVzIGRl
dGVjdGVkLCBzZWUgJ21hbiBidHJmcyg1KScuDQo+IFdBUk5JTkc6wqDCoCBEYXRhOiByYWlk
MSwgcmFpZDYNCj4NCj4gZG1lc2cgYXR0YWNoZWQuDQo+DQo+IE1vcmUgY29udGV4dCBpbiB0
aGUgcHJldmlvdXMgbWFpbGluZyBsaXN0IHBvc3QgYWJvdXQgdGhpcyAtIGhhcHB5IHRvIA0K
PiB0cnkgYW55IG5ldyBzdWdnZXN0aW9ucywgYW5kIEknbGwgZmlsZSBhIGJ1ZyBhcyB3ZWxs
Lg0KPg0KPiBUaGFua3MsDQo+IEFzaWYNCg==
