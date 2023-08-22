Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076C783926
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 07:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHVFQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHVFQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 01:16:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E8BDB;
        Mon, 21 Aug 2023 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692681377; x=1693286177; i=quwenruo.btrfs@gmx.com;
 bh=HhPI4QTvX9AZ5xRvUK8tZWzpcyeclYeD15sgmbWk2fE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=L5WY8a47bGt8L3TsxM3BWbzrx7RZu4mlp/4UjBgitiaWHbv3n0HzmQ5lu4vytHabpiE5Lg+
 AQo7kwtlo3+dJb5OOpXdahcX8Z9SEo4/Y8RpzNHXXYMU1ObCNw9eLzdY51hosiu0DegsxGCQ0
 TnXRRQ7kxPZFRL0tCJm2ZzdQdi0OVB5UhDRjq3pJzwLUqSB9z5zwkIlLkW/4SEkEDT0I6vb5+
 o7LLD+K71LHaV3jKRlZpzcNfUmB5AAmwGJTYBQh81K5Ybao4AlTPBv3m6MNW4OGUG6AaW9KlK
 PorpRWIqAZY+AraAwu4FDSKMlMZz6j4fuUdnrU44ErdD+JRYDuaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1pb25Y1GVk-0121cl; Tue, 22
 Aug 2023 07:16:16 +0200
Message-ID: <e1741eb5-db9e-4da6-9d0d-dbc09cb2b66d@gmx.com>
Date:   Tue, 22 Aug 2023 13:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20230821230129.31723-1-wqu@suse.com>
 <590727d0-5452-5469-711f-2b8cdff25719@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <590727d0-5452-5469-711f-2b8cdff25719@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2ostVDyuV8ddDLOeGVmpSlY5R5M+X1HiI7PRADep06PQ6R50ehF
 /fAlUENmAomJlGe6boXr4HN3S9Glo/MOmITOm8MX9bBzCFJZEtkCSZkS/9ezQgcPaOmt7Ui
 D3jVzl26diTLs+jvhx32mDbuKf1aj9udr/091bl+9ulJ9TQJHeJYqPgyZTkDnVXvdT/imaN
 e9gDFALYhDy/iMnIblFsw==
UI-OutboundReport: notjunk:1;M01:P0:ZB7Faca9vnc=;ySgT5R/GQnOjZV9w57ABmBZc6/g
 nWuwNHdfrHD3L3Q8BtgXbz3XxU2EhA79KjX+xlXHrqzIVJKjlta1eCr+tXHqBOpHryBgY1AqK
 /FN43eQ2met+Cuh7z0Z3EN+exLc0Ge9o5YZ8d0stFs8tk1WECrW+534FmbgEDrIhSgNvg9py9
 4o6U7+l254XETtDMK5lvhm8czAU4k6GSQmQ6bmvqHPZ9a0FtKtk6e6NxjCehgQPHDRmA6uQbq
 M+LQ+anvPhndWuUn5dc8cdVy7QtVl1RKj9dB+rfIjZbfpIkEao87nVzLTVqfs0CKJZI2oyj7U
 SIu0neD6jUPQiL2XEeSzryGkfOQJpSf4n0LDiJNqwvPxzxkkVT9NbwpKva+sjUqxQyRJpcb/A
 7SF/sHX60oRe+pNdiVNIY8qyw9w6fwvwUnBLYEMlNHHDWf9XsqmwTFh/tNHOUpzmbZef4g9YN
 ma2FUKFwjVNdN8yNKf94gWUktIPgUWqPWXSGWLvpPvvBtNwZ+C/n6rmNsUePFejfoTHZTKjZm
 SkUIoFblcVhOy65AzUR9K0msD861YFd36bxdodp8TVuQnOTdmt7AVZLgy/DHSdHvIMADJi8oV
 PFEIQJlgD73fChVl3xrlstmKYEtlCDkOTy1/gvOTUdXupDhkM/pneXmDj0Uk3LBAFjzfDpFd5
 pfBKSOyeX878XM7nreYwJP1+v4iyzML9R0DK6WSWBb2G2XBtnluEgi3FCXnQlFolfcEJS7JE6
 vuEKGCRLBv4LFMWU2ogQE2xUNxEkCqN5h8QM5PE4/0t6U8tU/ByQgA2qCOGtNKFAm5Zn44FT4
 ysm5Zi+1vu3MoBboLFurgvGWDAo7lfkDdOBk+zXaiYERn5YUC8PJoRScMVsMW5QFPc9yn4dwF
 +UyDfSMYXo7b1rDF0JP5/v8WPx+Xr1/f1aPIZi0VZx9ZlpOIrfdTbER/vqRnK6QXCz33kfZp4
 Dj2mSQwVgnstpVVK3elB2cGbKO4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjMvOC8yMiAxMjowNSwgQW5hbmQgSmFpbiB3cm90ZToNCj4gT24gMjIvMDgvMjAy
MyAwNzowMSwgUXUgV2VucnVvIHdyb3RlOg0KPj4gW0JVR10NCj4+IFRoZXJlIGlzIGEgdmVyeSBs
b3cgY2hhbmNlIHRvIGhpdCBkYXRhIGNzdW0gbWlzbWF0Y2ggKGNhdWdodCBieSBzY3J1YikNCj4+
IGR1cmluZyB0ZXN0IGNhc2UgYnRyZnMvMDZbMjM0NTY3XS4NCj4+DQo+PiBBZnRlciBzb21lIGV4
dHJhIGRpZ2dpbmcsIGl0IHR1cm5zIG91dCB0aGF0IHBsYWluIGZzc3RyZXNzIGl0c2VsZiBpcw0K
Pj4gZW5vdWdoIHRvIGNhdXNlIHRoZSBwcm9ibGVtOg0KPj4NCj4+IGBgYA0KPj4gd29ya2xvYWQo
KQ0KPj4gew0KPj4gwqDCoMKgwqBta2ZzLmJ0cmZzIC1mIC1tIHNpbmdsZSAtZCBzaW5nbGUgLS1j
c3VtIHNoYTI1NiAkZGV2MSA+IC9kZXYvbnVsbA0KPj4gwqDCoMKgwqBtb3VudCAkZGV2MSAkbW50
DQo+Pg0KPj4gwqDCoMKgwqAjJGZzc3RyZXNzIC1wIDEwIC1uIDEwMDAgLXcgLWQgJG1udA0KPj4g
wqDCoMKgwqB1bW91bnQgJG1udA0KPj4gwqDCoMKgwqBidHJmcyBjaGVjayAtLWNoZWNrLWRhdGEt
Y3N1bSAkZGV2MSB8fCBmYWlsDQo+PiB9DQo+Pg0KPj4gcnVudGltZT0xMDI0DQo+PiBmb3IgKCgg
aSA9IDA7IGkgPCAkcnVudGltZTsgaSsrICkpOyBkbw0KPj4gwqDCoMKgwqBlY2hvICI9PT0gJGkg
LyAkcnVudGltZSA9PT0iDQo+PiDCoMKgwqDCoHdvcmtsb2FkDQo+PiBkb25lDQo+PiBgYGANCj4+
DQo+PiBJbnNpZGUgYSBWTSB3aGljaCBoYXMgb25seSA2IGNvcmVzLCBhYm92ZSBzY3JpcHQgY2Fu
IHRyaWdnZXIgd2l0aCAxLzIwDQo+PiBwb3NzaWJpbGl0eS4NCj4+DQo+PiBbQ0FVU0VdDQo+PiBM
b2NhbGx5IEkgZ290IGEgbXVjaCBzbWFsbGVyIHdvcmtsb2FkIHRvIHJlcHJvZHVjZToNCj4+DQo+
PiDCoMKgwqDCoCRmc3N0cmVzcyAtcCA3IC1uIDUwIC1zIDE2OTEzOTY0OTMgLXcgLWQgJG1udCAt
diA+IC90bXAvZnNzdHJlc3MNCj4+DQo+PiBXaXRoIGV4dHJhIGtlcm5lbCB0cmFjZV9wcmlua3Qo
KSBvbiB0aGUgYnVmZmVyZWQvZGlyZWN0IHdyaXRlcy4NCj4+DQo+PiBJdCB0dXJucyBvdXQgdGhh
dCB0aGUgZm9sbG93aW5nIGRpcmVjdCB3cml0ZSBpcyBhbHdheXMgdGhlIGNhdXNlOg0KPj4NCj4+
IMKgwqAgYnRyZnNfZG9fd3JpdGVfaXRlcjogci9pPTUvMjgzIGJ1ZmZlcmVkIGZpbGVvZmY9NzA4
NjA4KDcwOTEyMSkgDQo+PiBsZW49MTIyODgoNzcxMikNCj4+DQo+PiDCoMKgIGJ0cmZzX2RvX3dy
aXRlX2l0ZXI6IHIvaT01LzI4MyBkaXJlY3QgZmlsZW9mZj04MTkyKDgxOTIpIA0KPj4gbGVuPTcz
NzI4KDczNzI4KSA8PDw8PA0KPj4NCj4+IMKgwqAgYnRyZnNfZG9fd3JpdGVfaXRlcjogci9pPTUv
MjgzIGRpcmVjdCBmaWxlb2ZmPTU4OTgyNCg1ODk4MjQpIA0KPj4gbGVuPTE2Mzg0KDE2Mzg0KQ0K
Pj4NCj4+IFdpdGggdGhlIGludm9sdmVkIGJ5dGUgbnVtYmVyLCBpdCdzIGVhc3kgdG8gcGluIGRv
d24gdGhlIGZzc3RyZXNzDQo+PiBvcGVhcnRpb246DQo+Pg0KPj4gwqAgMC8zMTogd3JpdGV2IGQw
L2YzWzI4NSAyIDAgMCAyOTYgMTQ1NzA3OF0gWzcwOTEyMSw4LDk2NF0gMA0KPj4gwqAgMC8zMjog
Y2hvd24gZDAvZjIgMzA4MTM0LzE3NjMyMzYgMA0KPj4NCj4+IMKgIDAvMzM6IGRvX2Fpb19ydyAt
IHhmc2N0bChYRlNfSU9DX0RJT0lORk8pIGQwL2YyWzI4NSAyIDMwODEzNCAxNzYzMjM2IA0KPj4g
MzIwIDE0NTcwNzhdIHJldHVybiAyNSwgZmFsbGJhY2sgdG8gc3RhdCgpDQo+PiDCoCAwLzMzOiBh
d3JpdGUgLSBpb19nZXRldmVudHMgZmFpbGVkIC00IDw8PDwNCj4+DQo+PiDCoCAwLzM0OiBkd3Jp
dGUgLSB4ZnNjdGwoWEZTX0lPQ19ESU9JTkZPKSBkMC9mM1syODUgMiAzMDgxMzQgMTc2MzIzNiAN
Cj4+IDMyMCAxNDU3MDc4XSByZXR1cm4gMjUsIGZhbGxiYWNrIHRvIHN0YXQoKQ0KPj4NCj4+IE5v
dGUgdGhlIDAvMzMsIHdoZW4gdGhlIGRhdGEgY3N1bSBtaXNtYXRjaCB0cmlnZ2VyZWQsIGl0IGFs
d2F5cyBmYWlsDQo+PiB3aXRoIC00ICgtRUlOVFIpLg0KPj4NCj4+IEl0IGxvb2tzIGxpa2Ugd2l0
aCBsdWNreSBlbm91Z2ggY29uY3VycmVuY3ksIHdlIGNhbiBnZXQgdG8gdGhlIGZvbGxvd2luZw0K
Pj4gc2l0dWF0aW9uIGluc2lkZSBmc3N0cmVzczoNCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBQcm9jZXNzIEHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBQcm9jZXNzIEINCj4+ICAgDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+IMKgIGRvX2Fpb19ydygpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8DQo+PiDCoCB8LSBpb19zdW1pdCgpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfA0KPj4gwqAgfC0gaW9fZ2V0X2V2ZW50cygpO8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8DQo+PiDCoCB8wqAgUmV0dXJuZWQgLUVJTlRSLCBidXQgSU8gaGFz
bid0wqAgfA0KPj4gwqAgfMKgIGZpbmlzaGVkLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4+IMKgIGAtIGZyZWUoYnVmKTvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBtYWxsb2MoKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgR290IHRoZSBzYW1lIG1lbW9yeSBvZiBAYnVmIGZyb20NCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgdGhyZWFkIEEuDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBNb2RpZnkgdGhlIG1lbW9yeQ0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgTm93IHRoZSBidWZmZXIgaXMgY2hhbmdlZCB3aGlsZQ0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgc3RpbGwgdW5kZXIgSU8NCj4+DQo+PiBUaGlzIGlzIHRoZSB0eXBpY2Fs
IGJ1ZmZlciBtb2RpZmljYXRpb24gZHVyaW5nIGRpcmVjdCBJTywgd2hpY2ggaXMgZ29pbmcNCj4+
IHRvIGNhdXNlIGNzdW0gbWlzbWF0Y2ggZm9yIGJ0cmZzLCBhbmQgYnRyZnMgcHJvcGVybHkgZGV0
ZWN0cyBpdC4NCj4+DQo+PiBUaGlzIGlzIHRoZSBkaXJlY3QgY2F1c2Ugb2YgdGhlIHByb2JsZW0u
DQo+Pg0KPj4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCwgaW9fdXJpbmcgd291bGQgdXNlIHNpZ25h
bHMgdG8gaGFuZGxlDQo+PiBzdWJtaXNzaW9uL2NvbXBsZXRpb24gb2YgSU9zLg0KPj4gVGh1cyBp
b191cmluZyBvcGVyYXRpb25zIHdvdWxkIGludGVycnVwdCBBSU8gb3BlcmF0aW9ucywgdGh1cyBj
YXVzaW5nDQo+PiB0aGUgYWJvdmUgcHJvYmxlbS4NCj4+DQo+PiBbRklYXQ0KPj4gVG8gZml4IHRo
ZSBwcm9ibGVtLCB3ZSBjYW4ganVzdCByZXRyeSBpb19nZXRldmVudHMoKSBzbyB0aGF0IHdlIGNh
bg0KPj4gcHJvcGVybHkgd2FpdCBmb3IgdGhlIElPLg0KPj4NCj4+IFRoaXMgcHJldmVudHMgdXMg
dG8gbW9kaWZ5IHRoZSBJTyBidWZmZXIgYmVmb3JlIHdyaXRlYmFjayByZWFsbHkNCj4+IGZpbmlz
aGVzLg0KPj4NCj4+IFdpdGggdGhpcyBmaXhlcywgSSBjYW4gbm8gbG9uZ2VyIHJlcHJvZHVjZSB0
aGUgZGF0YSBjb3JydXB0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1
QHN1c2UuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2Vsb2c6DQo+PiB2MjoNCj4+IC0gRml4IGFsbCBj
YWxsIHNpdGVzIG9mIGlvX2dldGV2ZW50cygpDQo+IA0KPiBTaG91bGQgaW9fZ2V0ZXZlbnRzKCkg
aW4gYWlvLXN0cmVzcy5jIGFuZCBmc3guYyBhbHNvIGJlIHVzaW5nIA0KPiBpb19nZXRfc2luZ2xl
X2V2ZW50KCk/DQoNCk5vcGUsIHRoaXMgcHJvYmxlbSBpcyBjYXVzZWQgYnkgdGhlIGZhY3QgdGhh
dCBpbyB1cmluZyBpcyB1c2luZyBzaWduYWwgDQp0byBub3RpZnkgdGhlIGNvbXBsZXRpb24sIHdo
aWNoIHdvdWxkIGludGVycnVwdCBpb19nZXRldmVudHMoKS4NCg0KRm9yIGFpby1zdHJlc3MuYywg
dGhlcmUgaXMgbm8gaW8gdXJpbmcgdXRpbGl6ZWQgYXQgYWxsLCB0aHVzIHRoZSBzaWduYWxzIA0K
YXJlIHJlYWwgc2lnbmFscyBwcm92aWRlZCBieSB1c2Vycy4NCkFsdGhvdWdoIGl0J3Mgc3RpbGwg
cG9zc2libGUgdGhhdCB1c2VyIHByb3ZpZGVkIHNpZ25hbHMgaW50ZXJydXB0IHRoZSANCm9wZXJh
dGlvbiBhbmQgY2F1c2UgdGhlIGNvcnJ1cHRpb24sIGl0J3Mgbm90IHJlYWxseSBhIGJpdCBjb25j
ZXJuIEFGQUlLLg0KDQpGb3IgZnN4LCBpbyB1cmluZyBhbmQgYWlvIGFyZSBleGNsdXNpdmUgdG8g
ZWFjaCBvdGhlciwgdGh1cyBpdCdzIHRoZSANCnNhbWUgYXMgYWlvLXN0cmVzcy5jLg0KDQpUaGFu
a3MsDQpRdQ0KPiANCj4gVGhhbmtzLCBBbmFuZA0KPiANCj4gDQo+PiAtIFVwZGF0ZSB0aGUgY29t
bWl0IG1lc3NhZ2UgdG8gc2hvdyB0aGUgcm9vdCBjYXVzZQ0KPj4gwqDCoCBUaGFua3MgYSBsb3Qg
dG8gSmVucyBBeGJvZSBmb3IgcG9pbnRpbmcgb3V0IHRoZSByb290IHByb2JsZW0uDQo+PiAtLS0N
Cj4+IMKgIGx0cC9mc3N0cmVzcy5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0NCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9sdHAvZnNzdHJlc3MuYyBiL2x0cC9mc3N0cmVzcy5jDQo+PiBpbmRleCA2NjQx
YTUyNS4uYWJlMjg3NDIgMTAwNjQ0DQo+PiAtLS0gYS9sdHAvZnNzdHJlc3MuYw0KPj4gKysrIGIv
bHRwL2Zzc3RyZXNzLmMNCj4+IEBAIC0yMDcyLDYgKzIwNzIsMjIgQEAgdm9pZCBpbm9kZV9pbmZv
KGNoYXIgKnN0ciwgc2l6ZV90IHN6LCBzdHJ1Y3QgDQo+PiBzdGF0NjQgKnMsIGludCB2ZXJib3Nl
KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAobG9uZyBsb25nKSBzLT5zdF9ibG9j
a3MsIChsb25nIGxvbmcpIHMtPnN0X3NpemUpOw0KPj4gwqAgfQ0KPj4gKyNpZmRlZiBBSU8NCj4+
ICtzdGF0aWMgaW50IGlvX2dldF9zaW5nbGVfZXZlbnQoc3RydWN0IGlvX2V2ZW50ICpldmVudCkN
Cj4+ICt7DQo+PiArwqDCoMKgIGludCByZXQ7DQo+PiArDQo+PiArwqDCoMKgIC8qDQo+PiArwqDC
oMKgwqAgKiBXZSBjYW4gZ2V0IC1FSU5UUiBpZiBjb21wZXRpbmcgd2l0aCBpb191cmluZyB1c2lu
ZyBzaWduYWwNCj4+ICvCoMKgwqDCoCAqIGJhc2VkIG5vdGlmaWNhdGlvbnMuIEZvciB0aGF0IGNh
c2UsIGp1c3QgcmV0cnkgdGhlIHdhaXQuDQo+PiArwqDCoMKgwqAgKi8NCj4+ICvCoMKgwqAgZG8g
ew0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGlvX2dldGV2ZW50cyhpb19jdHgsIDEsIDEsIGV2
ZW50LCBOVUxMKTsNCj4+ICvCoMKgwqAgfSB3aGlsZSAocmV0ID09IC1FSU5UUik7DQo+PiArwqDC
oMKgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gwqAgdm9pZA0KPj4g
wqAgYWZzeW5jX2Yob3BudW1fdCBvcG5vLCBsb25nIHIpDQo+PiDCoCB7DQo+PiBAQCAtMjExMSw3
ICsyMTI3LDcgQEAgYWZzeW5jX2Yob3BudW1fdCBvcG5vLCBsb25nIHIpDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgY2xvc2UoZmQpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+IMKg
wqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCBpZiAoKGUgPSBpb19nZXRldmVudHMoaW9fY3R4LCAxLCAx
LCAmZXZlbnQsIE5VTEwpKSAhPSAxKSB7DQo+PiArwqDCoMKgIGlmICgoZSA9IGlvX2dldF9zaW5n
bGVfZXZlbnQoJmV2ZW50KSkgIT0gMSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2KQ0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnRmKCIlZC8lbGxkOiBhZnN5bmMgLSBp
b19nZXRldmVudHMgZmFpbGVkICVkXG4iLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcm9jaWQsIG9wbm8sIGUpOw0KPj4gQEAgLTIyMjMsNyArMjIzOSw3IEBA
IGRvX2Fpb19ydyhvcG51bV90IG9wbm8sIGxvbmcgciwgaW50IGZsYWdzKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcm9jaWQsIG9wbm8sIGlzd3JpdGUgPyAi
YXdyaXRlIiA6ICJhcmVhZCIsIGUpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gYWlvX291
dDsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCBpZiAoKGUgPSBpb19nZXRldmVudHMoaW9f
Y3R4LCAxLCAxLCAmZXZlbnQsIE5VTEwpKSAhPSAxKSB7DQo+PiArwqDCoMKgIGlmICgoZSA9IGlv
X2dldF9zaW5nbGVfZXZlbnQoJmV2ZW50KSkgIT0gMSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICh2KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnRmKCIlZC8lbGxkOiAl
cyAtIGlvX2dldGV2ZW50cyBmYWlsZWQgJWRcbiIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHByb2NpZCwgb3BubywgaXN3cml0ZSA/ICJhd3JpdGUiIDogImFy
ZWFkIiwgZSk7DQo+IA0K
