Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C330E1E81
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfJWOrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 10:47:43 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:29623 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbfJWOrn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 10:47:43 -0400
Received: from [192.168.1.13] ([86.201.28.196])
        by mwinf5d42 with ME
        id H2ne2100B4DsWEm032nf76; Wed, 23 Oct 2019 16:47:39 +0200
X-ME-Helo: [192.168.1.13]
X-ME-Auth: bm9ibGV0X2p1bGllbkBvcmFuZ2UuZnI=
X-ME-Date: Wed, 23 Oct 2019 16:47:39 +0200
X-ME-IP: 86.201.28.196
From:   Julien_N <noblet_julien@orange.fr>
Subject: [PATCH] btrfs-progs: build: add missing symbols to libbtrfs - new
 patch
Autocrypt: addr=noblet_julien@orange.fr; keydata=
 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 vriT
To:     linux-btrfs@vger.kernel.org
Message-ID: <3c3f25e4-7f36-b1f3-0e82-9745e0eb84cb@orange.fr>
Date:   Wed, 23 Oct 2019 16:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QWNjb3JkaW5nIHRvIEpvaGFubmVzIFRodW1zaGlybiwgdGhlcmUgYXJlIG1pc3Npbmcgc29t
ZSBzeW1ib2xzIGluIGxpYmJ0cmZzLgoKSSd2ZSBtYWRlIHRoYXQgcGF0Y2gsIGl0IHNlZW0g
dG8gd29yayB3aXRoIHNuYXBwZXIuCgokIHNuYXBwZXIgLS12ZXJzaW9uCnNuYXBwZXIgMC44
LjQKZmxhZ3MgYnRyZnMsbHZtLGV4dDQseGF0dHJzLHJvbGxiYWNrLGJ0cmZzLXF1b3RhLG5v
LXNlbGludXgKCgpCUi4KCkp1bGllbgoKCi0tLQrCoE1ha2VmaWxlIHwgOSArKysrKysrLS0K
wqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggMjFiZjI3MTcuLjYxNmQ0Njlh
IDEwMDY0NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMTUwLDEzICsxNTAs
MTggQEAgY21kc19vYmplY3RzID0gY21kcy9zdWJ2b2x1bWUubyBjbWRzL2ZpbGVzeXN0ZW0u
bwpjbWRzL2RldmljZS5vIGNtZHMvc2NydWIubyBcCsKgwqDCoMKgIMKgwqDCoMKgwqDCoCBj
bWRzL2luc3BlY3QtZHVtcC1zdXBlci5vIGNtZHMvaW5zcGVjdC10cmVlLXN0YXRzLm8KY21k
cy9maWxlc3lzdGVtLWR1Lm8gXArCoMKgwqDCoCDCoMKgwqDCoMKgwqAgbWtmcy9jb21tb24u
byBjaGVjay9tb2RlLWNvbW1vbi5vIGNoZWNrL21vZGUtbG93bWVtLm8KwqBsaWJidHJmc19v
YmplY3RzID0gc2VuZC1zdHJlYW0ubyBzZW5kLXV0aWxzLm8ga2VybmVsLWxpYi9yYnRyZWUu
bwpidHJmcy1saXN0Lm8gXAotwqDCoMKgIMKgwqDCoCDCoMKgIGtlcm5lbC1saWIvcmFkaXgt
dHJlZS5vIGV4dGVudC1jYWNoZS5vIGV4dGVudF9pby5vIFwKK8KgwqDCoCDCoMKgwqAgwqDC
oCBrZXJuZWwtbGliL3JhZGl4LXRyZWUubyBleHRlbnQtY2FjaGUubyBleHRlbnRfaW8ubyBj
dHJlZS5vCnZvbHVtZXMubyBcCivCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoGRpc2staW8ubyBl
eHRlbnQtdHJlZS5vIGRlbGF5ZWQtcmVmLm8gcHJpbnQtdHJlZS5vCmNvbW1vbi9kZXZpY2Ut
c2Nhbi5vIFwKK8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgY29tbW9uL3V0aWxzLm8gZnJlZS1z
cGFjZS1jYWNoZS5vIGNvbW1vbi9wYXRoLXV0aWxzLm8Kcm9vdC10cmVlLm8gXAorwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqB0cmFuc2FjdGlvbi5vIGZpbGUtaXRlbS5vIGtlcm5lbC1saWIv
cmFpZDU2Lm8Ka2VybmVsLWxpYi90YWJsZXMubyBcCsKgwqDCoMKgIMKgwqDCoCDCoMKgIGtl
cm5lbC1saWIvY3JjMzJjLm8gY29tbW9uL21lc3NhZ2VzLm8gXArCoMKgwqDCoCDCoMKgwqAg
wqDCoCB1dWlkLXRyZWUubyB1dGlscy1saWIubyBjb21tb24vcmJ0cmVlLXV0aWxzLm8KwqBs
aWJidHJmc19oZWFkZXJzID0gc2VuZC1zdHJlYW0uaCBzZW5kLXV0aWxzLmggc2VuZC5oCmtl
cm5lbC1saWIvcmJ0cmVlLmggYnRyZnMtbGlzdC5oIFwKwqDCoMKgwqAgwqDCoMKgwqDCoMKg
IGtlcm5lbC1saWIvY3JjMzJjLmgga2VybmVsLWxpYi9saXN0Lmgga2VybmNvbXBhdC5oIFwK
wqDCoMKgwqAgwqDCoMKgwqDCoMKgIGtlcm5lbC1saWIvcmFkaXgtdHJlZS5oIGtlcm5lbC1s
aWIvc2l6ZXMuaCBrZXJuZWwtbGliL3JhaWQ1Ni5oIFwKLcKgwqDCoCDCoMKgwqDCoMKgwqAg
ZXh0ZW50LWNhY2hlLmggZXh0ZW50X2lvLmggaW9jdGwuaCBjdHJlZS5oIGJ0cmZzY2suaCB2
ZXJzaW9uLmgKK8KgwqDCoCDCoMKgwqDCoMKgwqAgZXh0ZW50LWNhY2hlLmggZXh0ZW50X2lv
LmggaW9jdGwuaCBjdHJlZS5oIGJ0cmZzY2suaCB2ZXJzaW9uLmggXAorwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgdm9sdW1lcy5oIGRpc2staW8uaCBkZWxheWVkLXJlZi5oIHBy
aW50LXRyZWUuaApmcmVlLXNwYWNlLWNhY2hlLmggXAorwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgY29tbW9uL2RldmljZS1zY2FuLmggY29tbW9uL3V0aWxzLmgKY29tbW9uL3Bh
dGgtdXRpbHMuaCB0cmFuc2FjdGlvbi5oCsKgbGliYnRyZnN1dGlsX21ham9yIDo9ICQoc2hl
bGwgc2VkIC1ybiAncy9eXCNkZWZpbmUKQlRSRlNfVVRJTF9WRVJTSU9OX01BSk9SIChbMC05
XSkrJCQvXDEvcCcgbGliYnRyZnN1dGlsL2J0cmZzdXRpbC5oKQrCoGxpYmJ0cmZzdXRpbF9t
aW5vciA6PSAkKHNoZWxsIHNlZCAtcm4gJ3MvXlwjZGVmaW5lCkJUUkZTX1VUSUxfVkVSU0lP
Tl9NSU5PUiAoWzAtOV0pKyQkL1wxL3AnIGxpYmJ0cmZzdXRpbC9idHJmc3V0aWwuaCkKwqBs
aWJidHJmc3V0aWxfcGF0Y2ggOj0gJChzaGVsbCBzZWQgLXJuICdzL15cI2RlZmluZQpCVFJG
U19VVElMX1ZFUlNJT05fUEFUQ0ggKFswLTldKSskJC9cMS9wJyBsaWJidHJmc3V0aWwvYnRy
ZnN1dGlsLmgpCi0tIAoyLjIzLjAKCg==
