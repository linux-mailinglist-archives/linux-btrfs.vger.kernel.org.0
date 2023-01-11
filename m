Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E61665668
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjAKIpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 03:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjAKIpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 03:45:24 -0500
Received: from out20-97.mail.aliyun.com (out20-97.mail.aliyun.com [115.124.20.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11582E1D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 00:45:20 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1332405|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0052209-6.34041e-05-0.994716;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Qq2qaP1_1673426713;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Qq2qaP1_1673426713)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:45:14 +0800
Date:   Wed, 11 Jan 2023 16:45:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: question about copy_file_range() between btrfs filesystem.
Message-Id: <20230111164513.85BA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_63BE74C20000000085B5_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------_63BE74C20000000085B5_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

question about copy_file_range() between btrfs filesystem.

test progam:
	attachment file(copy directly from 'man copy_file_range')

test result:
kernel: 6.1.4
1)in/out files in single btrfs subvol: OK

2)in/out files in single btrfs filesystem, but different subvols: OK

3)in/out files in different btrfs filesystems: ERROR Invalid cross-device link
   but as a compare, in/out files in different nfs filesystems(in same server): OK.
Question: 
Should we support copy_file_range() between btrfs filesystem?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/11


--------_63BE74C20000000085B5_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="copy_file_range.c"
Content-Disposition: attachment;
 filename="copy_file_range.c"
Content-Transfer-Encoding: base64

CgojZGVmaW5lIF9HTlVfU09VUkNFCiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5
cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCi8qIE9uIHZlcnNpb25zIG9mIGdsaWJj
IGJlZm9yZSAyLjI3LCB3ZSBtdXN0IGludm9rZSBjb3B5X2ZpbGVfcmFuZ2UoKQogICAgICAgdXNp
bmcgc3lzY2FsbCgyKSAqLwpzdGF0aWMgbG9mZl90CmNvcHlfZmlsZV9yYW5nZShpbnQgZmRfaW4s
IGxvZmZfdCAqb2ZmX2luLCBpbnQgZmRfb3V0LAogICAgICAgICAgICAgICAgICAgICBsb2ZmX3Qg
Km9mZl9vdXQsIHNpemVfdCBsZW4sIHVuc2lnbmVkIGludCBmbGFncykKewogICAgICAgcmV0dXJu
IHN5c2NhbGwoX19OUl9jb3B5X2ZpbGVfcmFuZ2UsIGZkX2luLCBvZmZfaW4sIGZkX291dCwKICAg
ICAgICAgICAgICAgICAgICAgb2ZmX291dCwgbGVuLCBmbGFncyk7Cn0KCmludAptYWluKGludCBh
cmdjLCBjaGFyICoqYXJndikKewogICAgICAgaW50IGZkX2luLCBmZF9vdXQ7CiAgICAgICBzdHJ1
Y3Qgc3RhdCBzdGF0OwogICAgICAgbG9mZl90IGxlbiwgcmV0OwoKICAgICAgIGlmIChhcmdjICE9
IDMpIHsKICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiAlcyA8c291cmNlPiA8
ZGVzdGluYXRpb24+XG4iLCBhcmd2WzBdKTsKICAgICAgICAgICAgICBleGl0KEVYSVRfRkFJTFVS
RSk7CiAgICAgICB9CgogICAgICAgZmRfaW4gPSBvcGVuKGFyZ3ZbMV0sIE9fUkRPTkxZKTsKICAg
ICAgIGlmIChmZF9pbiA9PSAtMSkgewogICAgICAgICAgICAgIHBlcnJvcigib3BlbiAoYXJndlsx
XSkiKTsKICAgICAgICAgICAgICBleGl0KEVYSVRfRkFJTFVSRSk7CiAgICAgICB9CgogICAgICAg
aWYgKGZzdGF0KGZkX2luLCAmc3RhdCkgPT0gLTEpIHsKICAgICAgICAgICAgICBwZXJyb3IoImZz
dGF0Iik7CiAgICAgICAgICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICAgICAgfQoKICAgICAg
IGxlbiA9IHN0YXQuc3Rfc2l6ZTsKCiAgICAgICBmZF9vdXQgPSBvcGVuKGFyZ3ZbMl0sIE9fQ1JF
QVQgfCBPX1dST05MWSB8IE9fVFJVTkMsIDA2NDQpOwogICAgICAgaWYgKGZkX291dCA9PSAtMSkg
ewogICAgICAgICAgICAgIHBlcnJvcigib3BlbiAoYXJndlsyXSkiKTsKICAgICAgICAgICAgICBl
eGl0KEVYSVRfRkFJTFVSRSk7CiAgICAgICB9CgogICAgICAgZG8gewogICAgICAgICAgICAgIHJl
dCA9IGNvcHlfZmlsZV9yYW5nZShmZF9pbiwgTlVMTCwgZmRfb3V0LCBOVUxMLCBsZW4sIDApOwog
ICAgICAgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKICAgICAgICAgICAgICBwZXJyb3IoImNvcHlf
ZmlsZV9yYW5nZSIpOwogICAgICAgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKICAgICAgICAg
ICAgICB9CgogICAgICAgICAgICAgIGxlbiAtPSByZXQ7CiAgICAgICB9IHdoaWxlIChsZW4gPiAw
ICYmIHJldCA+IDApOwoKICAgICAgIGNsb3NlKGZkX2luKTsKICAgICAgIGNsb3NlKGZkX291dCk7
CiAgICAgICBleGl0KEVYSVRfU1VDQ0VTUyk7Cn0KCg==
--------_63BE74C20000000085B5_MULTIPART_MIXED_--

