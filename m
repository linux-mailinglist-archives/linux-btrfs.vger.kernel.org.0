Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9117316FF77
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 14:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBZNDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 08:03:45 -0500
Received: from hadar.uberspace.de ([185.26.156.13]:34918 "EHLO
        hadar.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 08:03:45 -0500
Received: (qmail 30133 invoked from network); 26 Feb 2020 13:03:39 -0000
Received: from localhost (HELO ?192.168.178.66?) (127.0.0.1)
  by hadar.uberspace.de with SMTP; 26 Feb 2020 13:03:39 -0000
To:     linux-btrfs@vger.kernel.org
From:   btrfs@iooioio.hadar.uberspace.de
Subject: Confused about scrub output
Message-ID: <b3e5a1ec-0cb2-b8cb-e502-f84e1a08181c@hadar.uberspace.de>
Date:   Wed, 26 Feb 2020 14:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B5654D32841735C88AD4EFB8"
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------B5654D32841735C88AD4EFB8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello there,

I'm trying to figure out what the `btrfs scrub` output means. 
Specifically, I get an error summary that reports "no errors found" and 
then a warning, saying "errors detected during scrubbing, corrected". 
Checking dmesg didn't reveal anything obvious to me.

I'm using Marc Merlin's scrub script [1] but get the same behaviour when 
initiating a scrub directly.

Attached you will find the output of the script (`output.txt`) and a 
filtered (`dmesg | grep -i btrfs`) dmesg log (`dmesg.txt`).

My specs:

```
$ uname -a
Linux venus 5.3.0-40-generic #32~18.04.1-Ubuntu SMP Mon Feb 3 14:05:59 
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version # compiled from source
btrfs-progs v5.4.1

$ sudo btrfs fi show
Label: none  uuid: 7b39ba35-352a-4b76-9f33-79a05c7a1e1b
   Total devices 2 FS bytes used 426.41GiB
   devid    1 size 878.99GiB used 436.06GiB path /dev/sda5
   devid    2 size 894.25GiB used 436.06GiB path /dev/sdb

Label: 'storage'  uuid: cb041791-3931-429d-a249-d9fd4f2ba081
   Total devices 1 FS bytes used 728.32GiB
   devid    1 size 831.51GiB used 738.09GiB path /dev/sdc3

Label: 'snow'  uuid: 1ef734b2-5dc0-4349-8b5b-e4ba46e2f165
   Total devices 1 FS bytes used 761.16GiB
   devid    1 size 931.51GiB used 766.02GiB path 
/dev/mapper/luks-726a8c1f-e8f2-4d59-91d5-a0b52b43cb5e

Label: 'akasha'  uuid: 265cdb90-5b04-42a4-a40b-7ac9d2f9b881
   Total devices 1 FS bytes used 1.86TiB
   devid    1 size 2.73TiB used 1.89TiB path 
/dev/mapper/luks-aff1ccef-a303-470c-9eb3-27fdb97b544d

$ sudo btrfs fi df /
Data, RAID1: total=430.00GiB, used=422.39GiB
System, RAID1: total=64.00MiB, used=96.00KiB
Metadata, RAID1: total=6.00GiB, used=4.00GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

$ sudo btrfs fi df /media/josh/storage
Data, single: total=724.01GiB, used=722.89GiB
System, DUP: total=40.00MiB, used=96.00KiB
Metadata, DUP: total=7.00GiB, used=5.43GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

$ sudo btrfs fi df /media/josh/snow
Data, single: total=760.01GiB, used=759.11GiB
System, DUP: total=8.00MiB, used=96.00KiB
Metadata, DUP: total=3.00GiB, used=2.05GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

$ sudo btrfs fi df /media/josh/akasha
Data, single: total=1.83TiB, used=1.83TiB
System, DUP: total=40.00MiB, used=256.00KiB
Metadata, DUP: total=32.00GiB, used=28.27GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
```

I also tried getting help on Reddit [2] before coming here. Feel free to 
check out that thread.

Would appreciate some insight. Thanks in advance!

Josh

P.S.: This is my first time using a mailing list. I apologize if I'm 
doing this wrong and appreciate pointers on etiquette and best practices.

[1] http://marc.merlins.org/linux/scripts/btrfs-scrub
[2] 
https://www.reddit.com/r/btrfs/comments/f089hh/confused_about_scrub_output/

--------------B5654D32841735C88AD4EFB8
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.txt"

WyAgICAzLjQ3Nzg5NV0gQnRyZnMgbG9hZGVkLCBjcmMzMmM9Y3JjMzJjLWludGVsClsgICAg
My42NjE3NTBdIEJUUkZTOiBkZXZpY2UgbGFiZWwgc3RvcmFnZSBkZXZpZCAxIHRyYW5zaWQg
ODM3NyAvZGV2L3NkYzMKWyAgICAzLjY2MTg3MV0gQlRSRlM6IGRldmljZSBmc2lkIDdiMzli
YTM1LTM1MmEtNGI3Ni05ZjMzLTc5YTA1YzdhMWUxYiBkZXZpZCAyIHRyYW5zaWQgNTQ0NTAw
IC9kZXYvc2RiClsgICAgMy42NjE5OTNdIEJUUkZTOiBkZXZpY2UgZnNpZCA3YjM5YmEzNS0z
NTJhLTRiNzYtOWYzMy03OWEwNWM3YTFlMWIgZGV2aWQgMSB0cmFuc2lkIDU0NDUwMCAvZGV2
L3NkYTUKWyAgICAzLjY4MzM5N10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTUpOiBkaXNrIHNw
YWNlIGNhY2hpbmcgaXMgZW5hYmxlZApbICAgIDMuNjgzMzk4XSBCVFJGUyBpbmZvIChkZXZp
Y2Ugc2RhNSk6IGhhcyBza2lubnkgZXh0ZW50cwpbICAgIDMuNjkwNzA4XSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RhNSk6IGJkZXYgL2Rldi9zZGE1IGVycnM6IHdyIDAsIHJkIDAsIGZsdXNo
IDAsIGNvcnJ1cHQgNSwgZ2VuIDAKWyAgICA0LjAxNzE1Nl0gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYTUpOiBlbmFibGluZyBzc2Qgb3B0aW1pemF0aW9ucwpbICAgIDUuNDM5Nzk4XSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RhNSk6IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBlbmFibGVkClsg
IDIxNy4zMTEwNDhdIEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTogZGlzayBzcGFjZSBjYWNo
aW5nIGlzIGVuYWJsZWQKWyAgMjE3LjMxMTA0OV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMp
OiBoYXMgc2tpbm55IGV4dGVudHMKWyAgMjE4LjMyMzc3OF0gQlRSRlM6IGRldmljZSBsYWJl
bCBzbm93IGRldmlkIDEgdHJhbnNpZCA3ODQxIC9kZXYvZG0tMApbICAyMTguNjMyODE0XSBC
VFJGUyBpbmZvIChkZXZpY2UgZG0tMCk6IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBlbmFibGVk
ClsgIDIxOC42MzI4MTVdIEJUUkZTIGluZm8gKGRldmljZSBkbS0wKTogaGFzIHNraW5ueSBl
eHRlbnRzClsgIDIxOS4zNTYyODFdIEJUUkZTOiBkZXZpY2UgbGFiZWwgYWthc2hhIGRldmlk
IDEgdHJhbnNpZCA4ODE3IC9kZXYvZG0tMQpbICAyMTkuNjQ2MDUyXSBCVFJGUyBpbmZvIChk
ZXZpY2UgZG0tMSk6IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBlbmFibGVkClsgIDIxOS42NDYw
NTNdIEJUUkZTIGluZm8gKGRldmljZSBkbS0xKTogaGFzIHNraW5ueSBleHRlbnRzClsgIDIx
OS44MjkwOTZdIEJUUkZTIGluZm8gKGRldmljZSBkbS0xKTogYmRldiAvZGV2L21hcHBlci9s
dWtzLWFmZjFjY2VmLWEzMDMtNDcwYy05ZWIzLTI3ZmRiOTdiNTQ0ZCBlcnJzOiB3ciAwLCBy
ZCAwLCBmbHVzaCAwLCBjb3JydXB0IDIsIGdlbiAwClsxNzU4MC4zODM2NzRdIEJUUkZTIGlu
Zm8gKGRldmljZSBkbS0wKTogYmFsYW5jZTogc3RhcnQgLW11c2FnZT0wIC1zdXNhZ2U9MApb
MTc1ODAuMzg0NTE0XSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMCk6IGJhbGFuY2U6IGVuZGVk
IHdpdGggc3RhdHVzOiAwClsxNzU4MS4yODQ4NjddIEJUUkZTIGluZm8gKGRldmljZSBkbS0w
KTogYmFsYW5jZTogc3RhcnQgLWR1c2FnZT0wClsxNzU4MS4yODY1MzddIEJUUkZTIGluZm8g
KGRldmljZSBkbS0wKTogYmFsYW5jZTogZW5kZWQgd2l0aCBzdGF0dXM6IDAKWzE3NTgxLjgw
MDgyMl0gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTApOiBiYWxhbmNlOiBzdGFydCAtZHVzYWdl
PTIwClsxNzU4MS44MDI1MzVdIEJUUkZTIGluZm8gKGRldmljZSBkbS0wKTogYmFsYW5jZTog
ZW5kZWQgd2l0aCBzdGF0dXM6IDAKWzE3NTgxLjk3NzYwM10gQlRSRlMgaW5mbyAoZGV2aWNl
IGRtLTApOiBzY3J1Yjogc3RhcnRlZCBvbiBkZXZpZCAxClsyNDM0MC45NDk5ODFdIEJUUkZT
IGluZm8gKGRldmljZSBkbS0wKTogc2NydWI6IGZpbmlzaGVkIG9uIGRldmlkIDEgd2l0aCBz
dGF0dXM6IDAKWzI0MzQxLjA3NjY2M10gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTEpOiBiYWxh
bmNlOiBzdGFydCAtbXVzYWdlPTAgLXN1c2FnZT0wClsyNDM0MS4wODAzOTVdIEJUUkZTIGlu
Zm8gKGRldmljZSBkbS0xKTogYmFsYW5jZTogZW5kZWQgd2l0aCBzdGF0dXM6IDAKWzI0MzQx
LjMxNzgyNl0gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTEpOiBiYWxhbmNlOiBzdGFydCAtZHVz
YWdlPTAKWzI0MzQxLjMyMjI1MF0gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTEpOiBiYWxhbmNl
OiBlbmRlZCB3aXRoIHN0YXR1czogMApbMjQzNDEuNTUxNzA0XSBCVFJGUyBpbmZvIChkZXZp
Y2UgZG0tMSk6IGJhbGFuY2U6IHN0YXJ0IC1kdXNhZ2U9MjAKWzI0MzQxLjU1NjEyMV0gQlRS
RlMgaW5mbyAoZGV2aWNlIGRtLTEpOiBiYWxhbmNlOiBlbmRlZCB3aXRoIHN0YXR1czogMApb
MjQzNDEuNjg0MDU1XSBCVFJGUyBpbmZvIChkZXZpY2UgZG0tMSk6IHNjcnViOiBzdGFydGVk
IG9uIGRldmlkIDEKWzM4MjMwLjI1MDIwNF0gQlRSRlMgaW5mbyAoZGV2aWNlIGRtLTEpOiBz
Y3J1YjogZmluaXNoZWQgb24gZGV2aWQgMSB3aXRoIHN0YXR1czogMApbMzgyMzAuMjgzNTE4
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhNSk6IGJhbGFuY2U6IHN0YXJ0IC1tdXNhZ2U9MCAt
c3VzYWdlPTAKWzM4MjMwLjI4Mzk5MV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTUpOiBiYWxh
bmNlOiBlbmRlZCB3aXRoIHN0YXR1czogMApbMzgyMzAuMzExODkxXSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RhNSk6IGJhbGFuY2U6IHN0YXJ0IC1kdXNhZ2U9MApbMzgyMzAuMzEyNjk3XSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RhNSk6IGJhbGFuY2U6IGVuZGVkIHdpdGggc3RhdHVzOiAw
ClszODIzMC4zMzE1ODVdIEJUUkZTIGluZm8gKGRldmljZSBzZGE1KTogYmFsYW5jZTogc3Rh
cnQgLWR1c2FnZT0yMApbMzgyMzAuMzMyMDgyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhNSk6
IGJhbGFuY2U6IGVuZGVkIHdpdGggc3RhdHVzOiAwClszODIzMC4zNDUzODRdIEJUUkZTIGlu
Zm8gKGRldmljZSBzZGE1KTogc2NydWI6IHN0YXJ0ZWQgb24gZGV2aWQgMQpbMzgyMzAuMzQ1
ODQzXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhNSk6IHNjcnViOiBzdGFydGVkIG9uIGRldmlk
IDIKWzM5ODA5LjM5MDM1N10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTUpOiBzY3J1YjogZmlu
aXNoZWQgb24gZGV2aWQgMSB3aXRoIHN0YXR1czogMApbNDcxMjQuOTkyODM2XSBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RhNSk6IHNjcnViOiBmaW5pc2hlZCBvbiBkZXZpZCAyIHdpdGggc3Rh
dHVzOiAwCls0NzEyNS4zNzIzMDddIEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTogYmFsYW5j
ZTogc3RhcnQgLW11c2FnZT0wIC1zdXNhZ2U9MApbNDcxMjUuMzczNzAwXSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RjMyk6IGJhbGFuY2U6IGVuZGVkIHdpdGggc3RhdHVzOiAwCls0NzEyNS45
MTYzODBdIEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTogYmFsYW5jZTogc3RhcnQgLWR1c2Fn
ZT0wCls0NzEyNS45MTc5MjNdIEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTogYmFsYW5jZTog
ZW5kZWQgd2l0aCBzdGF0dXM6IDAKWzQ3MTI2LjI1ODA0Nl0gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYzMpOiBiYWxhbmNlOiBzdGFydCAtZHVzYWdlPTIwCls0NzEyNi4yNTkwMjVdIEJUUkZT
IGluZm8gKGRldmljZSBzZGMzKTogcmVsb2NhdGluZyBibG9jayBncm91cCA3ODkzOTczNzI5
MjggZmxhZ3MgZGF0YQpbNDcxMjkuODE0MjgzXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RjMyk6
IGZvdW5kIDI4IGV4dGVudHMKWzQ3MTMwLjgyNjk5MV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
YzMpOiBmb3VuZCAyOCBleHRlbnRzCls0NzEzMS41MDg5MjldIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGMzKTogYmFsYW5jZTogZW5kZWQgd2l0aCBzdGF0dXM6IDAKWzQ3MTMxLjc1ODc0M10g
QlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMpOiBzY3J1Yjogc3RhcnRlZCBvbiBkZXZpZCAxCls1
MTk5MC4zNTQ1NzddIEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTogc2NydWI6IGZpbmlzaGVk
IG9uIGRldmlkIDEgd2l0aCBzdGF0dXM6IDAK
--------------B5654D32841735C88AD4EFB8
Content-Type: text/plain; charset=UTF-8;
 name="output.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="output.txt"

PDEzPkZlYiAyNiAwMDo1NDozNCByb290OiBRdWljayBNZXRhZGF0YSBhbmQgRGF0YSBCYWxh
bmNlIG9mIC9tZWRpYS9qb3NoL3Nub3cgKC9kZXYvbWFwcGVyL2x1a3MtNzI2YThjMWYtZThm
Mi00ZDU5LTkxZDUtYTBiNTJiNDNjYjVlKQpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQg
b2YgNzY1IGNodW5rcwpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQgb2YgNzY1IGNodW5r
cwpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQgb2YgNzY1IGNodW5rcwo8MTM+RmViIDI2
IDAwOjU0OjM5IHJvb3Q6IFN0YXJ0aW5nIHNjcnViIG9mIC9tZWRpYS9qb3NoL3Nub3cKYnRy
ZnMgc2NydWIgc3RhcnQgLUJkIC9tZWRpYS9qb3NoL3Nub3cKc2NydWIgZGV2aWNlIC9kZXYv
bWFwcGVyL2x1a3MtNzI2YThjMWYtZThmMi00ZDU5LTkxZDUtYTBiNTJiNDNjYjVlIChpZCAx
KSBkb25lClNjcnViIHN0YXJ0ZWQ6ICAgIFdlZCBGZWIgMjYgMDA6NTQ6MzkgMjAyMApTdGF0
dXM6ICAgICAgICAgICBmaW5pc2hlZApEdXJhdGlvbjogICAgICAgICAxOjUyOjM5ClRvdGFs
IHRvIHNjcnViOiAgIDc2Ni4wMkdpQgpSYXRlOiAgICAgICAgICAgICAxMTUuNjNNaUIvcwpF
cnJvciBzdW1tYXJ5OiAgICBubyBlcnJvcnMgZm91bmQKV0FSTklORzogZXJyb3JzIGRldGVj
dGVkIGR1cmluZyBzY3J1YmJpbmcsIGNvcnJlY3RlZAo8MTM+RmViIDI2IDAyOjQ3OjE4IHJv
b3Q6IFF1aWNrIE1ldGFkYXRhIGFuZCBEYXRhIEJhbGFuY2Ugb2YgL21lZGlhL2pvc2gvYWth
c2hhICgvZGV2L21hcHBlci9sdWtzLWFmZjFjY2VmLWEzMDMtNDcwYy05ZWIzLTI3ZmRiOTdi
NTQ0ZCkKRG9uZSwgaGFkIHRvIHJlbG9jYXRlIDAgb3V0IG9mIDE5MTAgY2h1bmtzCkRvbmUs
IGhhZCB0byByZWxvY2F0ZSAwIG91dCBvZiAxOTEwIGNodW5rcwpEb25lLCBoYWQgdG8gcmVs
b2NhdGUgMCBvdXQgb2YgMTkxMCBjaHVua3MKPDEzPkZlYiAyNiAwMjo0NzoxOCByb290OiBT
dGFydGluZyBzY3J1YiBvZiAvbWVkaWEvam9zaC9ha2FzaGEKYnRyZnMgc2NydWIgc3RhcnQg
LUJkIC9tZWRpYS9qb3NoL2FrYXNoYQpzY3J1YiBkZXZpY2UgL2Rldi9tYXBwZXIvbHVrcy1h
ZmYxY2NlZi1hMzAzLTQ3MGMtOWViMy0yN2ZkYjk3YjU0NGQgKGlkIDEpIGRvbmUKU2NydWIg
c3RhcnRlZDogICAgV2VkIEZlYiAyNiAwMjo0NzoxOCAyMDIwClN0YXR1czogICAgICAgICAg
IGZpbmlzaGVkCkR1cmF0aW9uOiAgICAgICAgIDM6NTE6MjkKVG90YWwgdG8gc2NydWI6ICAg
MS44OVRpQgpSYXRlOiAgICAgICAgICAgICAxNDIuNDFNaUIvcwpFcnJvciBzdW1tYXJ5OiAg
ICBubyBlcnJvcnMgZm91bmQKV0FSTklORzogZXJyb3JzIGRldGVjdGVkIGR1cmluZyBzY3J1
YmJpbmcsIGNvcnJlY3RlZAo8MTM+RmViIDI2IDA2OjM4OjQ3IHJvb3Q6IFF1aWNrIE1ldGFk
YXRhIGFuZCBEYXRhIEJhbGFuY2Ugb2YgLyAoL2Rldi9zZGE1KQpEb25lLCBoYWQgdG8gcmVs
b2NhdGUgMCBvdXQgb2YgNDM3IGNodW5rcwpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQg
b2YgNDM3IGNodW5rcwpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQgb2YgNDM3IGNodW5r
cwo8MTM+RmViIDI2IDA2OjM4OjQ3IHJvb3Q6IFN0YXJ0aW5nIHNjcnViIG9mIC8KYnRyZnMg
c2NydWIgc3RhcnQgLUJkIC8Kc2NydWIgZGV2aWNlIC9kZXYvc2RhNSAoaWQgMSkgZG9uZQpT
Y3J1YiBzdGFydGVkOiAgICBXZWQgRmViIDI2IDA2OjM4OjQ3IDIwMjAKU3RhdHVzOiAgICAg
ICAgICAgZmluaXNoZWQKRHVyYXRpb246ICAgICAgICAgMDoyNjoxOQpUb3RhbCB0byBzY3J1
YjogICA0MzYuMDNHaUIKUmF0ZTogICAgICAgICAgICAgMjc2LjQ4TWlCL3MKRXJyb3Igc3Vt
bWFyeTogICAgbm8gZXJyb3JzIGZvdW5kCnNjcnViIGRldmljZSAvZGV2L3NkYiAoaWQgMikg
ZG9uZQpTY3J1YiBzdGFydGVkOiAgICBXZWQgRmViIDI2IDA2OjM4OjQ3IDIwMjAKU3RhdHVz
OiAgICAgICAgICAgZmluaXNoZWQKRHVyYXRpb246ICAgICAgICAgMjoyODoxNApUb3RhbCB0
byBzY3J1YjogICA0MzYuMDNHaUIKUmF0ZTogICAgICAgICAgICAgNDkuMDhNaUIvcwpFcnJv
ciBzdW1tYXJ5OiAgICBubyBlcnJvcnMgZm91bmQKV0FSTklORzogZXJyb3JzIGRldGVjdGVk
IGR1cmluZyBzY3J1YmJpbmcsIGNvcnJlY3RlZAo8MTM+RmViIDI2IDA5OjA3OjAxIHJvb3Q6
IFF1aWNrIE1ldGFkYXRhIGFuZCBEYXRhIEJhbGFuY2Ugb2YgL21lZGlhL2pvc2gvc3RvcmFn
ZSAoL2Rldi9zZGMzKQpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQgb2YgNzM0IGNodW5r
cwpEb25lLCBoYWQgdG8gcmVsb2NhdGUgMCBvdXQgb2YgNzM0IGNodW5rcwpEb25lLCBoYWQg
dG8gcmVsb2NhdGUgMSBvdXQgb2YgNzM0IGNodW5rcwo8MTM+RmViIDI2IDA5OjA3OjA4IHJv
b3Q6IFN0YXJ0aW5nIHNjcnViIG9mIC9tZWRpYS9qb3NoL3N0b3JhZ2UKYnRyZnMgc2NydWIg
c3RhcnQgLUJkIC9tZWRpYS9qb3NoL3N0b3JhZ2UKc2NydWIgZGV2aWNlIC9kZXYvc2RjMyAo
aWQgMSkgZG9uZQpTY3J1YiBzdGFydGVkOiAgICBXZWQgRmViIDI2IDA5OjA3OjA4IDIwMjAK
U3RhdHVzOiAgICAgICAgICAgZmluaXNoZWQKRHVyYXRpb246ICAgICAgICAgMToyMDo1OApU
b3RhbCB0byBzY3J1YjogICA3MzguMDJHaUIKUmF0ZTogICAgICAgICAgICAgMTU0LjY3TWlC
L3MKRXJyb3Igc3VtbWFyeTogICAgbm8gZXJyb3JzIGZvdW5kCldBUk5JTkc6IGVycm9ycyBk
ZXRlY3RlZCBkdXJpbmcgc2NydWJiaW5nLCBjb3JyZWN0ZWQK
--------------B5654D32841735C88AD4EFB8--
