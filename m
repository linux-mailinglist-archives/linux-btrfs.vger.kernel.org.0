Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4634829A54D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 08:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507374AbgJ0HMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 03:12:01 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:47865 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507372AbgJ0HMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 03:12:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4306178|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.336177-0.00478408-0.659039;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Ip-dQ.h_1603782716;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ip-dQ.h_1603782716)
          by smtp.aliyun-inc.com(10.147.44.129);
          Tue, 27 Oct 2020 15:11:56 +0800
Date:   Tue, 27 Oct 2020 15:11:59 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 6/7] btrfs: introduce new read_policy device
Cc:     linux-btrfs@vger.kernel.org, louis@waffle.tech
In-Reply-To: <eacd759d436260ccd586d52c9d2500e63b4aa614.1603751876.git.anand.jain@oracle.com>
References: <cover.1603751876.git.anand.jain@oracle.com> <eacd759d436260ccd586d52c9d2500e63b4aa614.1603751876.git.anand.jain@oracle.com>
Message-Id: <20201027151158.C1D4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_5F97C4F900000000C1CD_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------_5F97C4F900000000C1CD_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi, Anand Jain
Cc: Louis Jencka

> Read-policy type 'device' and device flag 'read-preferred':
> 
> The read-policy type device picks the device(s) flagged as
> read-preferred for reading chunks of type raid1, raid10,
> raid1c3 and raid1c4.
> 
> A system might contain SSD, nvme, iscsi or san lun, and which are all
> a non-rotational device, so it is not a good idea to set the read-preferred
> automatically. Instead device read-policy along with the read-preferred
> flag provides an ability to do it manually. This advance tuning is
> useful in more than one situation, for example,
>  - In heterogeneous-disk volume, it provides an ability to manually choose
>     the low latency disks for reading.
>  - Useful for more accurate testing.
>  - Avoid known problematic device from reading the chunk until it is
>    replaced (by marking the other good devices as read-preferred).

It is still OK to auto for the most common case of the mixed of ssd and
hdd?

I am trying 'manually if failed to auto' with a 'u8' var rather than a 'bool'
var.

There are 2 patch I am working but yet not completed.

and someone of them is based on 'btrfs: balance RAID1/RAID10 mirror
selection' from Louis Jencka louis@waffle.tech

Feel free to merge them into your patch as a new one please.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2020/10/27


--------_5F97C4F900000000C1CD_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="0001-btrfs-add-tier-score-to-device.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-tier-score-to-device.patch"
Content-Transfer-Encoding: base64

RnJvbSA4YThmNjQwNTA3M2Y4MzU1MzE2NjRhYWZhMzMzNTcwZmJhMjhjMzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB3YW5neXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+CkRh
dGU6IFR1ZSwgMjcgT2N0IDIwMjAgMDg6MTQ6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIIDEvM10g
YnRyZnM6IGFkZCB0aWVyIHNjb3JlIHRvIGRldmljZQoKV2UgdXNlIGEgc2luZ2xlIHNjb3JlIHZh
bHVlIHRvIGRlZmluZSB0aGUgdGllciBsZXZlbCBvZiBhIGRldmljZS4KRGlmZmVyZW50IHNjb3Jl
IG1lYW5zIGRpZmZlcmVudCB0aWVyLCBhbmQgYmlnZ2VyIGlzIGZhc3Rlci4KICAgIERBWCBkZXZp
Y2UoZGF4PTEpCiAgICBTU0QgZGV2aWNlKHJvdGF0aW9uYWw9MCkKICAgIEhERCBkZXZpY2Uocm90
YXRpb25hbD0xKQpUT0RPL0ZJWE1FOiBEaWZmZXJlbnQgYnVzKERJTU0vTlZNZS9TQVMvU0FUQS9W
aXJ0SU8vLi4uKSBzdXBwb3J0LgpUT0RPL0ZJWE1FOiBEaWZmZXJlbnQgbWVkaWEgZGV0YWlsKFNT
RCBNTEMvVExDLy4uOyBIREQgUE1SL1NNUi8uLi4pIHN1cHBvcnQuClRPRE8vRklYTUU6IFVzZXIt
YXNzaWduZWQgcHJvcGVydHkgdG8gbWFyayBhcyB0aGUgdG9wIHRpZXIgc2NvcmUuCgpJbiBtb3N0
IGNhc2UsIG9ubHkgMSBvciAyIHRpZXJzIGFyZSB1c2VkIGF0IHRoZSBzYW1lIHRpbWUsIHNvIHdl
IGdyb3VwIHRoZW0gaW50bwp0b3AgdGllciBhbmQgb3RoZXIgdGllcihzKS4KLS0tCiBmcy9idHJm
cy92b2x1bWVzLmMgfCAxOCArKysrKysrKysrKysrKysrKysKIGZzL2J0cmZzL3ZvbHVtZXMuaCB8
ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9m
cy9idHJmcy92b2x1bWVzLmMgYi9mcy9idHJmcy92b2x1bWVzLmMKaW5kZXggMTk5N2E3ZC4uZDc2
N2M5OSAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvdm9sdW1lcy5jCisrKyBiL2ZzL2J0cmZzL3ZvbHVt
ZXMuYwpAQCAtNjA4LDYgKzYwOCwyMiBAQCBzdGF0aWMgaW50IGJ0cmZzX2ZyZWVfc3RhbGVfZGV2
aWNlcyhjb25zdCBjaGFyICpwYXRoLAogCXJldHVybiByZXQ7CiB9CiAKKy8qCisgKiBHZXQgdGhl
IHRpZXIgc2NvcmUgdG8gdGhlIGRldmljZSwgaGlnaGVyIGlzIGZhc3Rlci4KKyAqIEZJWE1FOiBk
ZXRlY2ggYnVzKERJTU0vTlZNZSg0MCkvU0NTSSgzMCkvU0FUQSgyMCkvLi4pCisgKiBGSVhNRTog
bWVkaWEgZGV0YWlsKFNTRCBTTEMvTUxDLy4uLCkKKyAqIEZJWE1FOiB1c3JlLWRlZmluZWQgcHJv
cGVydHkgdG8gc2V0IHRvIG1heCBzY29yZSAxMjcKKyAqLworc3RhdGljIHZvaWQgZGV2X2dldF90
aWVyX3Njb3JlKHN0cnVjdCBidHJmc19kZXZpY2UgKmRldmljZSwgc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEpCit7CisJaWYgKGJsa19xdWV1ZV9kYXgocSkpCisJCWRldmljZS0+dGllcl9zY29yZSA9
IDUwOworCWVsc2UgaWYgKGJsa19xdWV1ZV9ub25yb3QocSkpCisJCWRldmljZS0+dGllcl9zY29y
ZSA9IDEwOworCWVsc2UKKwkJZGV2aWNlLT50aWVyX3Njb3JlID0gMDsKK30KKwogLyoKICAqIFRo
aXMgaXMgb25seSB1c2VkIG9uIG1vdW50LCBhbmQgd2UgYXJlIHByb3RlY3RlZCBmcm9tIGNvbXBl
dGluZyB0aGluZ3MKICAqIG1lc3Npbmcgd2l0aCBvdXIgZnNfZGV2aWNlcyBieSB0aGUgdXVpZF9t
dXRleCwgdGh1cyB3ZSBkbyBub3QgbmVlZCB0aGUKQEAgLTY2MCw2ICs2NzYsNyBAQCBzdGF0aWMg
aW50IGJ0cmZzX29wZW5fb25lX2RldmljZShzdHJ1Y3QgYnRyZnNfZnNfZGV2aWNlcyAqZnNfZGV2
aWNlcywKIAl9CiAKIAlxID0gYmRldl9nZXRfcXVldWUoYmRldik7CisJZGV2X2dldF90aWVyX3Nj
b3JlKGRldmljZSxxKTsKIAlpZiAoIWJsa19xdWV1ZV9ub25yb3QocSkpCiAJCWZzX2RldmljZXMt
PnJvdGF0aW5nID0gdHJ1ZTsKIApAQCAtMjU5OCw2ICsyNjE1LDcgQEAgaW50IGJ0cmZzX2luaXRf
bmV3X2RldmljZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgY29uc3QgY2hhciAqZGV2
aWNlX3BhdGgKIAogCWF0b21pYzY0X2FkZChkZXZpY2UtPnRvdGFsX2J5dGVzLCAmZnNfaW5mby0+
ZnJlZV9jaHVua19zcGFjZSk7CiAKKwlkZXZfZ2V0X3RpZXJfc2NvcmUoZGV2aWNlLHEpOwogCWlm
ICghYmxrX3F1ZXVlX25vbnJvdChxKSkKIAkJZnNfZGV2aWNlcy0+cm90YXRpbmcgPSB0cnVlOwog
CmRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmggYi9mcy9idHJmcy92b2x1bWVzLmgKaW5k
ZXggMzAyYzkyMy4uNWZmYTQyOSAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvdm9sdW1lcy5oCisrKyBi
L2ZzL2J0cmZzL3ZvbHVtZXMuaApAQCAtMTM4LDYgKzEzOCw4IEBAIHN0cnVjdCBidHJmc19kZXZp
Y2UgewogCXN0cnVjdCBjb21wbGV0aW9uIGtvYmpfdW5yZWdpc3RlcjsKIAkvKiBGb3Igc3lzZnMv
RlNJRC9kZXZpbmZvL2RldmlkLyAqLwogCXN0cnVjdCBrb2JqZWN0IGRldmlkX2tvYmo7CisKKwl1
OCB0aWVyX3Njb3JlOyAvKiBzdG9yYWdlIHRpZXJfc2NvcmU7IGhpZ2hlciBpcyBmYXN0ZXIgKi8K
IH07CiAKIC8qCi0tIAoyLjI5LjEKCg==
--------_5F97C4F900000000C1CD_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="0003-btrfs-tier-aware-mirror-path-select.patch"
Content-Disposition: attachment;
 filename="0003-btrfs-tier-aware-mirror-path-select.patch"
Content-Transfer-Encoding: base64

RnJvbSA0YWMyZmMwYTNiZTY3MGUwOTYwOTI4MDEyZjVmMTU2YjUwZjJjNjlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB3YW5neXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+CkRh
dGU6IFR1ZSwgMjcgT2N0IDIwMjAgMDk6MzM6MjEgKzA4MDAKU3ViamVjdDogW1BBVENIIDMvM10g
YnRyZnM6IHRpZXItYXdhcmUgbWlycm9yIHBhdGggc2VsZWN0CgpUaGlzIGV4dGVuZGVkIHRoZSBw
YXRjaCAnYnRyZnM6IGJhbGFuY2UgUkFJRDEvUkFJRDEwIG1pcnJvciBzZWxlY3Rpb24nIGZyb20g
bG91aXNAd2FmZmxlLnRlY2gKLSBhZGQgdGhlIHRpZXItYXdhcmUgZmVhdHVyZQotLS0KIGZzL2J0
cmZzL3ZvbHVtZXMuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2ZzL2J0cmZzL3ZvbHVtZXMuYyBiL2ZzL2J0cmZzL3ZvbHVtZXMuYwppbmRleCBkMzgwYjIwLi5j
YzRhNzkxIDEwMDY0NAotLS0gYS9mcy9idHJmcy92b2x1bWVzLmMKKysrIGIvZnMvYnRyZnMvdm9s
dW1lcy5jCkBAIC01NTYyLDYgKzU1NjIsOSBAQCBpbnQgYnRyZnNfaXNfcGFyaXR5X21pcnJvcihz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgdTY0IGxvZ2ljYWwsIHU2NCBsZW4pCiAJcmV0
dXJuIHJldDsKIH0KIAorLyogVXNlZCBmb3Igcm91bmQtcm9iaW4gYmFsYW5jaW5nIFJBSUQxL1JB
SUQxMCByZWFkcy4gKi8KK3N0YXRpYyBhdG9taWNfdCBycl9jb3VudGVyID0gQVRPTUlDX0lOSVQo
MCk7CisKIHN0YXRpYyBpbnQgZmluZF9saXZlX21pcnJvcihzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywKIAkJCSAgICBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFwLCBpbnQgZmlyc3QsCiAJCQkg
ICAgaW50IGRldl9yZXBsYWNlX2lzX29uZ29pbmcpCkBAIC01NTcyLDYgKzU1NzUsMTEgQEAgc3Rh
dGljIGludCBmaW5kX2xpdmVfbWlycm9yKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLAog
CWludCB0b2xlcmFuY2U7CiAJc3RydWN0IGJ0cmZzX2RldmljZSAqc3JjZGV2OwogCisJLyogdGll
ci1hd2FyZSAqLworCWludCB0b3BfdGllcl9udW1fc3RyaXBlczsKKwlpbnQgdG9wX3RpZXJfc3Ry
aXBlX2lkeHNbNF07CisJdTggdG9wX3RpZXJfc2NvcmUgPSAwOworCiAJQVNTRVJUKChtYXAtPnR5
cGUgJgogCQkgKEJUUkZTX0JMT0NLX0dST1VQX1JBSUQxX01BU0sgfCBCVFJGU19CTE9DS19HUk9V
UF9SQUlEMTApKSk7CiAKQEAgLTU1ODAsNyArNTU4OCwyOSBAQCBzdGF0aWMgaW50IGZpbmRfbGl2
ZV9taXJyb3Ioc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sCiAJZWxzZQogCQludW1fc3Ry
aXBlcyA9IG1hcC0+bnVtX3N0cmlwZXM7CiAKLQlwcmVmZXJyZWRfbWlycm9yID0gZmlyc3QgKyBj
dXJyZW50LT5waWQgJSBudW1fc3RyaXBlczsKKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3N0cmlwZXM7
ICsraSkKKwl7CisJCWlmIChtYXAtPnN0cmlwZXNbaV0uZGV2LT50aWVyX3Njb3JlID4gdG9wX3Rp
ZXJfc2NvcmUpCisJCXsKKwkJCXRvcF90aWVyX3Njb3JlID0gbWFwLT5zdHJpcGVzW2ldLmRldi0+
dGllcl9zY29yZTsKKwkJCXRvcF90aWVyX3N0cmlwZV9pZHhzWzBdID0gaTsKKwkJCXRvcF90aWVy
X251bV9zdHJpcGVzID0gMTsKKwkJfQorCQllbHNlIGlmIChtYXAtPnN0cmlwZXNbaV0uZGV2LT50
aWVyX3Njb3JlID09IHRvcF90aWVyX3Njb3JlKQorCQl7CisJCQl0b3BfdGllcl9zdHJpcGVfaWR4
c1t0b3BfdGllcl9udW1fc3RyaXBlc10gPSBpOworCQkJdG9wX3RpZXJfbnVtX3N0cmlwZXMrKzsK
KwkJfQorCX0KKwlwcmVmZXJyZWRfbWlycm9yID0gZmlyc3Q7CisJaWYgKHRvcF90aWVyX251bV9z
dHJpcGVzID4gMSkKKwl7CisJCXByZWZlcnJlZF9taXJyb3IgKz0gdG9wX3RpZXJfc3RyaXBlX2lk
eHNbKCh1bnNpZ25lZClhdG9taWNfaW5jX3JldHVybigmcnJfY291bnRlcikpICUgdG9wX3RpZXJf
bnVtX3N0cmlwZXNdOworCX0KKwllbHNlCisJeworCQlwcmVmZXJyZWRfbWlycm9yICs9IHRvcF90
aWVyX3N0cmlwZV9pZHhzWzBdOworCX0KIAogCWlmIChkZXZfcmVwbGFjZV9pc19vbmdvaW5nICYm
CiAJICAgIGZzX2luZm8tPmRldl9yZXBsYWNlLmNvbnRfcmVhZGluZ19mcm9tX3NyY2Rldl9tb2Rl
ID09Ci0tIAoyLjI5LjEKCg==
--------_5F97C4F900000000C1CD_MULTIPART_MIXED_--

