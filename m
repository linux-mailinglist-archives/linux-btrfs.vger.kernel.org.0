Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DB4231AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhJEUZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:25:08 -0400
Received: from esa.hc5583-2.iphmx.com ([216.71.137.146]:43604 "EHLO
        esa3.hc5583-2.iphmx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231266AbhJEUZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:25:07 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 16:25:07 EDT
X-IronPort-RemoteIP: 160.153.247.227
X-IronPort-MID: 40792
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: None
X-IronPort-MailFlowPolicy: $ACCEPTED
IronPort-Data: A9a23:ko9ap6zrWWeMI+h7YLR6t+ckwyrEfRIJ4+MujC+fZmUNrF6WrkVUn
 DEfXmGDPKuPNDbyfdoiOojipxwFupHXmNQ3S1dtry00HyNBpPSfOdnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si9AttENlFEkvU2ybuOU5NXsZ2YhGGeIdA970Ug6wrZh39Yy6TSEK1jlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTakjUG32zhH5P7pGTU2FFEYUd6EOdgKMq
 0Qv+5nilo/R109F5tpICd8XeGVTKlLZFVHmZna7x8FOK/WNz8A/+v9TCRYSVatYoxmgrdpdy
 vdxj4yfSVZzAIyXssNBViANRkmSPYUekFPGCUWkvNb7I0/uKiW0hawzVwdsYdJeoLwoaY1N3
 aRwxDQlbxaNgPie3Ki2TOVjnM07LMj7eogYvxmMyBmFVal3G/gvRY3Bx49emy4+h/xhNu3TY
 +44UT5LTVP5Nkgn1lA/TchWcP2Trn3+dSBIgEmcr6M3pW7e0Ep0wdDFNNvTZ8yiXsRQmUCdp
 2nc+CL1D3kyMN2Z1Cqt6XalmO7JmmXgW+o6ELy+6+5CnECe3G8SGRBQU1anydG9i0ijS/pDN
 lYXvCwjscAa8E2tU8mkDk3giH6NtR0RQd9ZEul87gyRooLQ4gCEFjQBTzVBZdgiuec4XzEn0
 FKV2d/kbRRrsbuIWS3N3reTsTa7OCxTI3VqTSsFSxYVptP/uo8opgzAQ8wlE6OviNDxXzbqz
 FiiqCk4mqUYkOYN2rmn8EHGhnSqq4ShZgo04BjHW2uj7wpyTJKifZal91nW7/9fLZyUSlSap
 z4Dgcf2xOQPC4yd0SqTTOQIGZmt5u2ZK3uE2BhoBZZJ3zCs/WOzZpFL/Dx7DEFkLt0PcCfkZ
 0nXuAVcopRUemapBYdzYoSsG9gwlIDuHtHsV/SSZd1LCrB1dQmZ9SUob0qZ1GPyl08gua46M
 JafN82rCB4yDaVh0jOwR+ATzrIkyyYWymbaRJS9xBOiuZKaZXiLQK1fGFSLZ+E9qqiDpW399
 9dZKcaQ0BJ3W+r7aSDM7cgVIExiBXw6A47xuuRXcfKGKwtiXmomDpf5xbInZNU0wvh9meLB/
 3X7UUhdoHL7hHvYLgKGMyo4LrfwdZl6pHM/eycrOD6A33klfoGo4KobepArZ7gs78Rp0fVzS
 f8IcNnGCfNKIhzD+jICap7xt4dicxOvrQiJIjCjbT04YoJgAQPO5Jn5fWPH8CgIHmy7vNU/r
 5Wv0wraRdwIQAEKJMLXbuKHylq+vHMSguVvRw3DJdw7UEHt9phrIivgk7kzIsckJhDKxz/c3
 AGTaT8cpO/coIU82NbMjKGA6YyuFoNWGktcDS/WxbGsPC/V8yyt2+doVOeObzn1S2Tu/Kmka
 PkTxu3gdvsKgD5it4t6Ab9inPNvz9vou7pTzwAiF3LOB3yvC7VyK3+Kx8hEtoVHwqJUqAywV
 k+VvNJdf6iKUOvhEVgDLhAkM7Sr2vQdmz2U5vMwSG3+5Sll8eLaeUVVIxyFiSgbJ7xwWKshw
 OEztcQL5B6XhR8jM9LAhSdRn0yIL3oSUuMtv5UGGpLtgxEDwUtFaoeaBzKeyJWObcdNdEIuI
 zmbjazqiLNYykfEeHo6D2TAx6xWgtITu3hiyF4ENVWhkNfOgvgx0BpXtz8wS2x9yhRBweNbP
 G9xK014P6OA+z5nn45IWGXEMwVAAg+Y8B2p41sOiGjQTk3uXWvIREU5OOCf+U0I/nhWViNR9
 76cz2zsVXDscd2Z9i8zX1xjrObpQMZt3gTFnIasGMHtN507ZyjihqbxNEIIrAfiCMI1wkbAo
 IFC+Od2e7HnKH5Ji6I+Aoiek78XTXisIG1EU+57/b8EB0ncfy230DmKbUu2f6tlI/3M416QF
 9F0JYRJWgjW/CKPqCIKAakSC7t1gvNv790HEpvvJGgUor2epTlo6cOPrQDxgWYqR5NllsNVA
 ofQcSCTA3S4in5dmmuLp85BUkK8YN4ATBHhxuPz9ugVf7oHseZpeFsuw5O0uGmQOQpjuRmTu
 Wv+i7T+zvQnkNo02tKxSeAZW1rxc4msEuWQthu+uMlUYMjCK9nDrUUTp0WP0xlqAIb9ku9fz
 dyl2OMbFmuc1Frqewg1UKVt20WECQtekQaX3g/KwKFmoBa/
IronPort-HdrOrdr: A9a23:tY60LKy82+nIhgv4rscHKrPwOb1zdoMgy1knxilNoHtuE/Bw9v
 rBoB1173PJYVoqMk3I+uruBEDoexq1yXcS2+Is1NyZMTUOwlHYT72KlbGSoQEIRxeOk9K1rp
 0BT5RD
X-IronPort-AV: E=Sophos;i="5.85,349,1624338000"; 
   d="scan'208";a="40792"
X-MGA-submission: =?us-ascii?q?MDFOL61DFieB1RqbwKX22cSMeD81d9jX4SqrFg?=
 =?us-ascii?q?VDsLcwASD204NgVdcXmL6B3G/l6Io8dSrYbFqeFc+Hv/FPKEukfhOrPy?=
 =?us-ascii?q?O5Ayavb2kqHF0kCsXqe70IuZPDhDaasJCyzwvQrkbgnVAoi30yu/OcI0?=
 =?us-ascii?q?ub?=
Message-Id: <cc2e01$17qo@ob1.hc5583-2.iphmx.com>
Received: from ip-160-153-247-227.ip.secureserver.net (HELO User) ([160.153.247.227])
  by ob1.hc5583-2.iphmx.com with SMTP; 05 Oct 2021 15:16:02 -0500
Reply-To: <rev_peter200421@yahoo.co.jp>
From:   "Admin" <infor@trendgraphix.com>
Subject: RE = Congratulations_ _
Date:   Tue, 5 Oct 2021 22:16:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

WhatsApp Admin

Congratulations

Your email has won $1 million United States Dollar ($1,000,000) in the 2021 WhatsApp lottery and you are expected to claim it as quickly as possible or your lottery will be transferred to the second runner up.

Its a way to appreciate your commitment to WhatsApp and the impression you have given other people about WhatsApp.

For Security reasons your winning number is (WHTZPPX9) please keep this information very confidential to avoid being hunted by hoodlum when you finally claim your winning.

Your Name
Your Address
Age
Your country
Your winning number
Your Telephone numbers

Yours Sincerely,
WhatsApp Admin
