Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56E24D272
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHUKeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 06:34:05 -0400
Received: from mail5.teicee.fr ([193.227.130.56]:43710 "EHLO mail5.teicee.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgHUKeD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 06:34:03 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 06:34:01 EDT
Received: from mail6.teicee.fr (mail6.teicee.fr [193.227.130.62])
        by mail5.teicee.fr (Postfix) with ESMTP id 7E29B8A9
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 12:27:31 +0200 (CEST)
Received: from mail2.teicee.com (mail.teicee.com [109.205.64.90])
        by mail6.teicee.fr (Postfix) with ESMTP id 7D5F595AC
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 12:27:31 +0200 (CEST)
Received: from localhost (amavis.teicee.fr [10.40.90.43])
        by mail2.teicee.com (Postfix) with ESMTP id 74D63A005C6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 12:27:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at amavis.teicee.fr
Received: from [192.168.0.2] (c188-150-191-233.bredband.comhem.se [188.150.191.233])
        by mail2.teicee.com (Postfix) with ESMTPSA id 20C21A004D6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 12:27:30 +0200 (CEST)
To:     linux-btrfs@vger.kernel.org
From:   Guillaume Chauvat <guillaume@chauvat.eu>
Subject: system freeze while running balance on Linux 5.8
Autocrypt: addr=guillaume@chauvat.eu; prefer-encrypt=mutual; keydata=
 mQENBFYt+qcBCADUb5i0GkO9nuKyX0QdSx4BVb1Bzuu//3L98M6mk5qnBobh96FgkkcM21eS
 J103c+t4RxP7CwiUx+dXGnVm+30qXxpGtQcsiK+Ks1gI0NIRTL2Ky/A3VlukNqB5fxQGdqNh
 jpRAEfMvPFuuLErNwEy177WWjru+K9gKSkYccUWJBui4CkROJH+bC3HkH5JjTHd7W3eNnLNj
 zKpm9TRiJIrhKev0sPkYaN9MUTHfs87YaqlOGv/W2qAFN8kwKKVZznxC5cBrgCHsFQyZDMn7
 6mtvJQdEq0QS1YOdRNgMW9zNslMPxD0mx7k/08ed6c9HRafDNN72XqDLhIa6peQ0kDODABEB
 AAG0KEd1aWxsYXVtZSBDaGF1dmF0IDxndWlsbGF1bWVAY2hhdXZhdC5ldT6JAT0EEwEIACcF
 AlY3a9wCGwMFCQlmAYAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQFTz2RSyT6IhBpAf+
 NQqfTE2e+xjZJL7QCD5TzwiF5+7a6tGV7izzkD6ZdPAoBNe31Bl920th+G33XyD4zyWoVmNL
 DtnfCPqKGTYlV2uUbEvx6T55DrR5NXzOsU/soTB1XupH9Srz+SxxmFXOFGWlhguRaW669TpD
 8tFfx1dOyOUdShBGqA4gHbBlfrb0aCZKVG+l+sZANSpFcAaxEu3SpOWhCw7RDXnBq0Zq9oR2
 6oJrZyKqkmPLDmNilDNjgv7USpd1yErzz3eIZxIDnk3xv5/4hF9kFxLorzt9riZpR1+/YO5R
 l0i93nnugezeriEjYsFmuBKdi06NdySalAg/PQxdibhYD6rWQBEVi7kBDQRWLfqnAQgAzp86
 ICnG0KNWrF/eWo67Yr/WMx3wteJ/oK5EKYISXzMXHYUEMrZw/2kkP91GiKzMuIZ107k1rFHW
 YiiwlV96AS9LQNrjZUuyj+RNFbCIgagiwCN/Z+3OrdgCObz+raKxHb9l+y9qmrK68E8FiBrG
 GlH68TMESSzbDpLlho+DdgwYFMBYQ0sinQV57VuS3ZpMNP5yas/1Aba0jhQgGyg17lLaohgP
 sIrMJxwlWNwf0Qg/F2FRB208q6zzoBmBHxbEUm2uhWcqgvDt2JMeEbk8h5rsGOMkq3iln5Q8
 MZ/bkTEJWKwO59Pizo1pQRcVPABkipWBsTRXqU+QaZ9c1gjpPwARAQABiQElBBgBAgAPBQJW
 LfqnAhsMBQkJZgGAAAoJEBU89kUsk+iI+rUIAI2QzxYwzK01OVw5EUuutPAl6ReSxGq7BpFl
 rXtqNVssb9GZ8e+yHBfSBZNHUWNLPqjgJLGfzJItJitSVhLCqqHDzlWtLtE8lZPbzbBT3+32
 R4jxEgZBaruaTXtvJoNGD4thvqkQywiPQtuUGbC8o9uug1teVsoiXf3BRGlBt3NN9p3X9Zo4
 6STtrselrhnOEFHcYJuABrrcgOxRbZDlHXSnBvSzN4ewYGH8tEjbIFosO4VP4HpDz2HpdPx8
 YuJm9+Y4Www/BYv8vwVhNQYb3J6wQFzPKp75wtBk5uWgYuKWnrTxfIoubFAuMpgGHZJelCeZ
 yPa6b62Q9fd7yI9wOgI=
Message-ID: <f109d2b6-715e-58ec-9f52-370dcead4b17@chauvat.eu>
Date:   Fri, 21 Aug 2020 12:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------33E174E4124E15C62BCCECB5"
Content-Language: en-US-large
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------33E174E4124E15C62BCCECB5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

I had 2x3TB btrfs raid1 (full at ~90%) and decided to add a third
identical disk. After running btrfs device add /dev/sdc1 /home, I did
$ sudo btrfs balance start /home

This worked fine for a few hours, but the system eventually froze
completely (mouse/keyboard totally unresponsive) before it finished and
I hard rebooted it. Now the system freezes after a few minutes every
time I start a balance. The filesystem seems to work totally fine
otherwise. I ran a scrub that showed no errors.

I attach an extract from journalctl -p4 that might be relevant (please
tell me if you need something else!).


Thanks,
Guillaume




In addition:
$ btrfs filesystem df /home

                  [141] 12:17
Data, RAID1: total=2.49TiB, used=2.49TiB
System, RAID1: total=32.00MiB, used=384.00KiB
Metadata, RAID1: total=12.00GiB, used=10.19GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


$ sudo btrfs filesystem usage /home


Overall:
    Device size:		   8.19TiB
    Device allocated:		   5.00TiB
    Device unallocated:		   3.19TiB
    Device missing:		     0.00B
    Used:			   4.99TiB
    Free (estimated):		   1.60TiB	(min: 1.60TiB)
    Data ratio:			      2.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,RAID1: Size:2.49TiB, Used:2.49TiB (99.94%)
   /dev/mapper/Heim0	   2.18TiB
   /dev/mapper/Heim1	   2.18TiB
   /dev/mapper/Heim2	 626.00GiB

Metadata,RAID1: Size:12.00GiB, Used:10.19GiB (84.91%)
   /dev/mapper/Heim0	  11.00GiB
   /dev/mapper/Heim1	   9.00GiB
   /dev/mapper/Heim2	   4.00GiB

System,RAID1: Size:32.00MiB, Used:384.00KiB (1.17%)
   /dev/mapper/Heim1	  32.00MiB
   /dev/mapper/Heim2	  32.00MiB

Unallocated:
   /dev/mapper/Heim0	 550.52GiB
   /dev/mapper/Heim1	 550.49GiB
   /dev/mapper/Heim2	   2.11TiB

--------------33E174E4124E15C62BCCECB5
Content-Type: text/plain; charset=UTF-8;
 name="btrfs.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btrfs.log"

QXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IGtlcm5lbCBCVUcgYXQgZnMvYnRyZnMv
ZXh0ZW50LXRyZWUuYzoxMTQyIQpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogaW52
YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkKQXVnIDE4IDIwOjU5OjAz
IEthcm1hbiBrZXJuZWw6IENQVTogMSBQSUQ6IDExMzEzIENvbW06IGJ0cmZzIFRhaW50ZWQ6
IFAgICAgICAgICAgIE9FICAgICA1LjguMS1hcmNoMS0xICMxCkF1ZyAxOCAyMDo1OTowMyBL
YXJtYW4ga2VybmVsOiBIYXJkd2FyZSBuYW1lOiBHaWdhYnl0ZSBUZWNobm9sb2d5IENvLiwg
THRkLiBaMTcwLUdhbWluZyBLMy9aMTcwLUdhbWluZyBLMywgQklPUyBGMSAxMi8wNy8yMDE1
CkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBSSVA6IDAwMTA6dXBkYXRlX2lubGlu
ZV9leHRlbnRfYmFja3JlZisweDI0Ni8weDI1MCBbYnRyZnNdCkF1ZyAxOCAyMDo1OTowMyBL
YXJtYW4ga2VybmVsOiBDb2RlOiA4YiAwNCAyNCBlOSAxOSBmZiBmZiBmZiAwZiAwYiA0MSBi
YyAwZCAwMCAwMCAwMCA0MSBiZiAwZCAwMCAwMCAwMCBlOSBkYSBmZSBmZiBmZiA0MSBmNyBk
YyA0OSA2MyBjNCA0OCAzOSBjOCAwZiA4NiA1YyBmZiBmZiBmZiA8MGY+IDBiIDBmIDFmIDg0
IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwID4KQXVnIDE4IDIwOjU5OjAzIEthcm1h
biBrZXJuZWw6IFJTUDogMDAxODpmZmZmYTYwZTAwY2M3OTcwIEVGTEFHUzogMDAwMTAyMDIK
QXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IFJBWDogMDAwMDAwMDAwMDAwMDAwMSBS
Qlg6IDAwMDAwMDAwMDAwMDMzZTQgUkNYOiAwMDAwMDAwMDAwMDAwMDAwCkF1ZyAxOCAyMDo1
OTowMyBLYXJtYW4ga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwMDA0MTkgUlNJOiAwMDAwMDAw
MDAwMDAzM2ZkIFJESTogZmZmZjkyYTVkZWJhMGI1OApBdWcgMTggMjA6NTk6MDMgS2FybWFu
IGtlcm5lbDogUkJQOiBmZmZmOTJhNWRlYmEwYjU4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBS
MDk6IGZmZmZhNjBlMDBjYzdhMGMKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IFIx
MDogZmZmZjkyYWYzOWMxZmRkMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAw
MDAwMDAwMDAxCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBSMTM6IGZmZmY5MmFj
Y2U1NjcwZTAgUjE0OiAwMDAwMDAwMDAwMDAzM2ZjIFIxNTogMDAwMDAwMDAwMDAwMDBiMgpB
dWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogRlM6ICAwMDAwN2Y3YjFlZDdmMWMwKDAw
MDApIEdTOmZmZmY5MmFmNDFhODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApB
dWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5l
bDogQ1IyOiAwMDAwM2YyZmRiNjczMDAwIENSMzogMDAwMDAwMGY1ZDY2NDAwNiBDUjQ6IDAw
MDAwMDAwMDAzNjA2ZTAKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IERSMDogMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAw
MDAwCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBEUjM6IDAwMDAwMDAwMDAwMDAw
MDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMApBdWcgMTgg
MjA6NTk6MDMgS2FybWFuIGtlcm5lbDogQ2FsbCBUcmFjZToKQXVnIDE4IDIwOjU5OjAzIEth
cm1hbiBrZXJuZWw6ICByZW1vdmVfZXh0ZW50X2JhY2tyZWYrMHgyZC8weDcwIFtidHJmc10K
QXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6ICBfX2J0cmZzX2ZyZWVfZXh0ZW50Lmlz
cmEuMCsweDQzNy8weDkzMCBbYnRyZnNdCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVs
OiAgX19idHJmc19ydW5fZGVsYXllZF9yZWZzKzB4MjU1LzB4MTBlMCBbYnRyZnNdCkF1ZyAx
OCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiAgYnRyZnNfcnVuX2RlbGF5ZWRfcmVmcysweDY0
LzB4MWYwIFtidHJmc10KQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6ICBidHJmc19j
b21taXRfdHJhbnNhY3Rpb24rMHhiMS8weGEzMCBbYnRyZnNdCkF1ZyAxOCAyMDo1OTowMyBL
YXJtYW4ga2VybmVsOiAgcHJlcGFyZV90b19tZXJnZSsweDIxZi8weDI2MCBbYnRyZnNdCkF1
ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiAgcmVsb2NhdGVfYmxvY2tfZ3JvdXArMHgy
ZWIvMHg2MDAgW2J0cmZzXQpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogIGJ0cmZz
X3JlbG9jYXRlX2Jsb2NrX2dyb3VwKzB4MTVjLzB4MzAwIFtidHJmc10KQXVnIDE4IDIwOjU5
OjAzIEthcm1hbiBrZXJuZWw6ICBidHJmc19yZWxvY2F0ZV9jaHVuaysweDI3LzB4YzAgW2J0
cmZzXQpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogIGJ0cmZzX2JhbGFuY2UrMHg3
NzEvMHhlZjAgW2J0cmZzXQpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogID8gYnRy
ZnNfaW9jdGxfYmFsYW5jZSsweDEyNS8weDM0MCBbYnRyZnNdCkF1ZyAxOCAyMDo1OTowMyBL
YXJtYW4ga2VybmVsOiAgYnRyZnNfaW9jdGxfYmFsYW5jZSsweDI5Mi8weDM0MCBbYnRyZnNd
CkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiAga3N5c19pb2N0bCsweDgyLzB4YzAK
QXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6ICBfX3g2NF9zeXNfaW9jdGwrMHgxNi8w
eDIwCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiAgZG9fc3lzY2FsbF82NCsweDQ0
LzB4NzAKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6ICBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5CkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVs
OiBSSVA6IDAwMzM6MHg3ZjdiMWVlOWQ4ZWIKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJu
ZWw6IENvZGU6IEJhZCBSSVAgdmFsdWUuCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVs
OiBSU1A6IDAwMmI6MDAwMDdmZmYyNWM3YjIyOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFY
OiAwMDAwMDAwMDAwMDAwMDEwCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBSQVg6
IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2ZmZjI1YzdiMmMwIFJDWDogMDAwMDdmN2Ix
ZWU5ZDhlYgpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogUkRYOiAwMDAwN2ZmZjI1
YzdiMmMwIFJTSTogMDAwMDAwMDBjNDAwOTQyMCBSREk6IDAwMDAwMDAwMDAwMDAwMDMKQXVn
IDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IFJCUDogMDAwMDAwMDAwMDAwMDAwMyBSMDg6
IDAwMDA1NWYzYzI5OGYyZTAgUjA5OiAwMDAwN2Y3YjFlZjY3YTQwCkF1ZyAxOCAyMDo1OTow
MyBLYXJtYW4ga2VybmVsOiBSMTA6IDAwMDAwMDAwMDAwMDAwNzYgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwMQpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtl
cm5lbDogUjEzOiAwMDAwN2ZmZjI1YzdjODJmIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6
IDAwMDAwMDAwMDAwMDAwMDAKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IE1vZHVs
ZXMgbGlua2VkIGluOiBmdXNlIHJma2lsbCB0dW4gbnZpZGlhX2RybShQT0UpIG52aWRpYV9t
b2Rlc2V0KFBPRSkgbnZpZGlhKFBPRSkgaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21t
b24geDg2X3BrZ190ZW1wX3RoZXJtYWwgaW50ZWxfcG93ZXJjbGFtcCBjb3JldGVtcCBpVENP
X3dkdCBrdm1faW50PgpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogIGJsYWtlMmJf
Z2VuZXJpYyBsaWJjcmMzMmMgY3JjMzJjX2dlbmVyaWMgeG9yIHJhaWQ2X3BxIGhpZF9nZW5l
cmljIHVzYmhpZCBoaWQgdWFzIHVzYl9zdG9yYWdlIGRtX2NyeXB0IGNiYyBlbmNyeXB0ZWRf
a2V5cyBkbV9tb2QgdHJ1c3RlZCB0cG0gcm5nX2NvcmUgc2VyaW9fcmF3IGF0a2JkIGxpYnBz
MiBjcmN0MTA+CkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiAtLS1bIGVuZCB0cmFj
ZSA3M2JiYjM2NTRkZmRmMjZmIF0tLS0KQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6
IFJJUDogMDAxMDp1cGRhdGVfaW5saW5lX2V4dGVudF9iYWNrcmVmKzB4MjQ2LzB4MjUwIFti
dHJmc10KQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IENvZGU6IDhiIDA0IDI0IGU5
IDE5IGZmIGZmIGZmIDBmIDBiIDQxIGJjIDBkIDAwIDAwIDAwIDQxIGJmIDBkIDAwIDAwIDAw
IGU5IGRhIGZlIGZmIGZmIDQxIGY3IGRjIDQ5IDYzIGM0IDQ4IDM5IGM4IDBmIDg2IDVjIGZm
IGZmIGZmIDwwZj4gMGIgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgMGYgMWYgNDQgMDAgMDAg
PgpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDogUlNQOiAwMDE4OmZmZmZhNjBlMDBj
Yzc5NzAgRUZMQUdTOiAwMDAxMDIwMgpBdWcgMTggMjA6NTk6MDMgS2FybWFuIGtlcm5lbDog
UkFYOiAwMDAwMDAwMDAwMDAwMDAxIFJCWDogMDAwMDAwMDAwMDAwMzNlNCBSQ1g6IDAwMDAw
MDAwMDAwMDAwMDAKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJuZWw6IFJEWDogMDAwMDAw
MDAwMDAwMDQxOSBSU0k6IDAwMDAwMDAwMDAwMDMzZmQgUkRJOiBmZmZmOTJhNWRlYmEwYjU4
CkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBSQlA6IGZmZmY5MmE1ZGViYTBiNTgg
UjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmE2MGUwMGNjN2EwYwpBdWcgMTggMjA6
NTk6MDMgS2FybWFuIGtlcm5lbDogUjEwOiBmZmZmOTJhZjM5YzFmZGQwIFIxMTogMDAwMDAw
MDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDAwMDAwMDEKQXVnIDE4IDIwOjU5OjAzIEthcm1h
biBrZXJuZWw6IFIxMzogZmZmZjkyYWNjZTU2NzBlMCBSMTQ6IDAwMDAwMDAwMDAwMDMzZmMg
UjE1OiAwMDAwMDAwMDAwMDAwMGIyCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBG
UzogIDAwMDA3ZjdiMWVkN2YxYzAoMDAwMCkgR1M6ZmZmZjkyYWY0MWE4MDAwMCgwMDAwKSBr
bmxHUzowMDAwMDAwMDAwMDAwMDAwCkF1ZyAxOCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBD
UzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkF1ZyAx
OCAyMDo1OTowMyBLYXJtYW4ga2VybmVsOiBDUjI6IDAwMDA3ZjdiMWVlOWQ4YzEgQ1IzOiAw
MDAwMDAwZjVkNjY0MDA2IENSNDogMDAwMDAwMDAwMDM2MDZlMApBdWcgMTggMjA6NTk6MDMg
S2FybWFuIGtlcm5lbDogRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAw
MDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKQXVnIDE4IDIwOjU5OjAzIEthcm1hbiBrZXJu
ZWw6IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAw
MDAwMDAwMDAwMDAwNDAwCkF1ZyAxOCAyMDo1OToyNiBLYXJtYW4ga2VybmVsOiBJUHY2OiBN
TEQ6IGNsYW1waW5nIFFSViBmcm9tIDEgdG8gMiEKQXVnIDE4IDIwOjU5OjU3IEthcm1hbiBr
ZXJuZWw6IHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEgc3R1Y2sgZm9yIDIy
cyEgW2J0cmZzLXRyYW5zYWN0aTo0OTBdCg==
--------------33E174E4124E15C62BCCECB5--
