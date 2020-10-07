Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7752863D0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJGQYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 12:24:25 -0400
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:34244
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgJGQYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Oct 2020 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602087863; bh=PxMwWzXvs+dqOoH0/FHvFmQpYH2JguaCUHYAVLLmaiw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LlqJvgYWtqIuUi175z/2J3pNcE+D1WXCvGFAO63XtY5qqzJYXBkrJKeRMZPVXN9D/e3snUXAligDYW7Ko6YkYIQeb/OdW33b9Wd/V9tm7CL2NPuQ5HpvNVdGwj3c1Dk6a2u3KOH9beglenfEKBgTAj/cP57x25qPQeTnzPzBfXSN7yUSaDDnk0KKg9Gi46EwVr3jYgmzpGekzFfq4cUgkAvLNkcNqef5TAw1y4pQRaDjI4cMOHZgjV9zJssdWgeWZk7D9puVoWAQUI/GfOs+fv5IlKFuBPtJ4Gb4fq3TfsHW7nbi/DBCX6SuY37h2lmfvP4oNR/uqyuSB04Yi40Oyg==
X-YMail-OSG: eFDkHdoVM1nYhLlI4Woh9m82mXms2CSOvs.6lGYBflOY6whFUpTAj6qa.QS6FyV
 .MlLYxq4jEICQVB5kT2PCbHpsMgSRoMcOaq3UspI__7kQq1wG3IB44bpFWSCVJK7MRSxsmjmB7Lg
 pFPpkkEcwuxYwO5iLVy_Nz3FF8_eyhcMK.DMlSfmtVrkXVAgf7agalSmAX1Z1uDiE7IoP33eXVYl
 7YQKvctnaC8gKyYi5hSPd3CUPWgiOTMIBPwqDZzBUmxK7q7537BGnnIeV25kbcBuvKBsKxVNnm80
 3n.U8.aoWLM1GDZzoHy.LLs0okAqeSztbnEhW0M7xZxBC3B9R8LZ6jJziiOn_81f.vZQ6eB.Fiu2
 dWLa6qPF.djPLb2YLoCzFmc1_mm_AJe1JtW1AcjcqYHcCrbs6VMq5uqlh35VFJsKcdd_mhfGcnng
 MvhVjrk1MrpVazQ6R4ikuIGrOOfocYsiezGUhuvz9G4BS1d8tKpE0vTgqNvIDUiUOL4QY0iLy40D
 sc7YViQcs6BKn1u5dJNT4PfAK6zbRN_o25DwhYnz8HLcPEHVZsO3CJRNCGrHEEpV2Ytke7eGt5ub
 rWlveHXbg5QJY4xgsOQp6akuT8Dbc9lV_Rh7Y2T0NVOiUnaPa7aNgRoHyfVG2Jf4cmIxt1jUF9Pn
 Jb17xdyxAKZM6PyWNkIiZc8MtQizg82ardPtkCM5e0CLWv19uv1SbcumrNdbAp3bp5tfEsveoATk
 OQyj9pPSNC2ddocaPDYfqx1a0d6jCn2ZukF6nYrJ5tvg98OpY34Aj0Bc_2hFc6PD0FBlrhnaum8k
 qdp0UgfGsQFkoGiX.t3gV16vpAH8TbOjW8fFNuq4GMuuGtXut1Whz9YquUeZFCfP97pTWHvB.pps
 kMngbxLgMjfNIrOvJ76WrV5m7CMkUF_g7bGGaGNu9dAgTEN3MgwmV5QacnkN_oQLRLjoc6JiLzey
 3VGGkL28e68xQjBW4JB5ur2i4Fx9LKwGdM9R43UYqcEZEbvgRSCNj4TBpzR0M.NP4eju.gpnx3bC
 NkFIh0JrDsOn7ZPCwNsEEuhIG8IAaCfAwgQZeEZ00n2J5EqzdTZbx8v1aHXpPs14A.y5BYKfczZY
 Lq8MiXzs1ejJnFvewADnRRKoJMJwlltEW4HJgsuhKtaZjl8M7PmWLBFZn4R_Cl4D8tKOcax4Ago4
 _22uJDCiZP8WeHj6ukDgyd8VmWDhbHFePx0crI95zKnN2Fpw3.jiTLnh0caB851l5L4v0K95mv.C
 BzOb2XcrAVnau7R12_lJE.ndUDZCpebBB3veoOex3Idx9uAhCXTkq7jP6OQe8skQfqvdvrleRKzl
 jnbpYaLq6Cw9qvYwpVP98fbJ.y3_Ae9ET4LSB3P0EuTCdpdmB0vBfw2KwWRfeYuF3salmL1FulMu
 e0lc0JtOp1Yu8rzq4ZqGf0bRKH8VoOpzf_q55mAvwuHLBzA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 16:24:23 +0000
Date:   Wed, 7 Oct 2020 16:24:22 +0000 (UTC)
From:   Marilyn Robert <fredodinga22@gmail.com>
Reply-To: marilyobert@gmail.com
Message-ID: <1960100655.143882.1602087862365@mail.yahoo.com>
Subject: =?UTF-8?B?0J3QsNGY0LzQuNC70LAg0LrQsNGYINCz0L7RgdC/0L7QtNCw0YDQvtGC?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <1960100655.143882.1602087862365.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCtCd0LDRmNC80LjQu9CwINC60LDRmCDQs9C+0YHQv9C+0LTQsNGA0L7Rgg0KDQrQiNCw0YEg
0YHRg9C8IDY4LdCz0L7QtNC40YjQvdCwINC20LXQvdCwLCDQutC+0ZjQsCDRgdGC0YDQsNC00LAg
0L7QtCDQv9GA0L7QtNC+0LvQttC10L0g0LrQsNGA0YbQuNC90L7QvCDQvdCwINC00L7RmNC60LAs
INC+0LQg0YHQuNGC0LUg0LzQtdC00LjRhtC40L3RgdC60Lgg0LjQvdC00LjQutCw0YbQuNC4LCDQ
vNC+0ZjQsNGC0LAg0YHQvtGB0YLQvtGY0LHQsCDQvdCw0LLQuNGB0YLQuNC90LAg0YHQtSDQstC7
0L7RiNC4INC4INC+0YfQuNCz0LvQtdC00L3QviDQtSDQtNC10LrQsCDQvNC+0LbQtdCx0Lgg0L3Q
tdC80LAg0LTQsCDQttC40LLQtdCw0Lwg0L/QvtCy0LXRnNC1INC+0LQg0YjQtdGB0YIg0LzQtdGB
0LXRhtC4INC60LDQutC+INGA0LXQt9GD0LvRgtCw0YIg0L3QsCDQsdGA0LfQuNC+0YIg0YDQsNGB
0YIg0Lgg0LHQvtC70LrQsNGC0LAg0YjRgtC+INGB0LUg0ZjQsNCy0YPQstCwINC60LDRmCDQvdC1
0LAuINCc0L7RmNC+0YIg0YHQvtC/0YDRg9CzINC/0L7Rh9C40L3QsCDQvdC10LrQvtC70LrRgyDQ
s9C+0LTQuNC90Lgg0L3QsNC90LDQt9Cw0LQg0Lgg0L3QsNGI0LjRgtC1INC00L7Qu9Cz0Lgg0LPQ
vtC00LjQvdC4INCx0YDQsNC6INC90LUg0LHQtdCwINCx0LvQsNCz0L7RgdC70L7QstC10L3QuCDR
gdC+INC90LjRgtGDINC10LTQvdC+INC00LXRgtC1LCDQv9C+INC90LXQs9C+0LLQsNGC0LAg0YHQ
vNGA0YIg0LPQviDQvdCw0YHQu9C10LTQuNCyINGG0LXQu9C+0YLQviDQvdC10LPQvtCy0L4g0LHQ
vtCz0LDRgtGB0YLQstC+Lg0KDQrQlNC+0LDRk9Cw0Lwg0LrQsNGYINCy0LDRgSDQvtGC0LrQsNC6
0L4g0YHQtSDQv9C+0LzQvtC70LjQsiDQt9CwINGC0L7QsCwg0L/QvtC00LPQvtGC0LLQtdC9INGB
0YPQvCDQtNCwINC00L7QvdC40YDQsNC8INGB0YPQvNCwINC+0LQgMiwgMzAwLCAwMDAg0LXQstGA
0LAg0LfQsCDQv9C+0LzQvtGIINC90LAg0YHQuNGA0L7QvNCw0YjQvdC40YLQtSwg0YHQuNGA0L7Q
vNCw0YjQvdC40YLQtSDQuCDQv9C+0LzQsNC70LrRgyDQv9GA0LjQstC40LvQtdCz0LjRgNCw0L3Q
uNGC0LUg0LzQtdGT0YMg0LLQsNGI0LjRgtC1INGB0L7QsdGA0LDQvdC40ZjQsCAvINC+0L/RiNGC
0LXRgdGC0LLQvi4g0JfQsNCx0LXQu9C10LbQtdGC0LUg0LTQtdC60LAg0L7QstC+0Zgg0YTQvtC9
0LQg0LUg0LTQtdC/0L7QvdC40YDQsNC9INCy0L4g0LHQsNC90LrQsCDQutCw0LTQtSDRiNGC0L4g
0YDQsNCx0L7RgtC10YjQtSDQvNC+0ZjQvtGCINGB0L7Qv9GA0YPQsy4gQXBwcmVjaWF0ZdC1INGG
0LXQvdCw0Lwg0LDQutC+INC+0LHRgNC90LXRgtC1INCy0L3QuNC80LDQvdC40LUg0L3QsCDQvNC+
0LXRgtC+INCx0LDRgNCw0ZrQtSDQt9CwINC/0YDQvtC/0LDQs9C40YDQsNGa0LUg0L3QsCDQvNCw
0YHQsNC20LDRgtCwINC90LAg0LrRgNCw0LvRgdGC0LLQvtGC0L4sINGc0LUg0LLQuCDQtNCw0LTQ
sNC8INC/0L7QstC10ZzQtSDQtNC10YLQsNC70Lgg0LfQsCDRgtC+0LAg0LrQsNC60L4g0LTQsCDQ
v9C+0YHRgtCw0L/QuNGC0LUuDQoNCtCR0LvQsNCz0L7QtNCw0YDQsNC8DQrQky3Rk9CwINCc0LXR
gNC40LvQuNC9INCg0L7QsdC10YDRgg==
