Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6972969F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 08:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375447AbgJWGuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 02:50:00 -0400
Received: from sonic308-10.consmr.mail.ne1.yahoo.com ([66.163.187.33]:35325
        "EHLO sonic308-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373209AbgJWGuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 02:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603435799; bh=wMqcY+1+xzZpq40CBU4bY3tP7WHdEhFlqGtQtFHhz5U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NRl1VzA7wCcxV2zLPTnbc8d1TLDd10hZDmDjIlAQHTRqIDIcE/T+T7x7BYo3PgkIqwPCPbsPd5K9VPQIAKPw4kwMtz4ddF4t2lnYlQmHq3K/WJTOnivlxsBvz43OZK8LZPIzoG2DA8YJm/HmkI9/w792YJ2JrbzquzxDHq0YHlNXI/GaK86HE65k/n7V9SY5G4qvPhZQLFKge8UOnFUjnhTtH86ufkSk0o9ThBHNbQj8LNQFHQnIWaGJHZ+hRiYUD88oiNJWKBT0Gy1841noMRchVpVDbI+jm0a0pkszQ9zQRxPcNY5C9MhaDcT+mQLCu5bbyb0cd95OClO95JpBFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603435799; bh=h3GTa35uktlGFmQbF9qeQE+FGGuDC45mAPS0+KZcnPk=; h=Date:From:Subject; b=s1f0i+WX0o6ODKbW898DHsHwdk76yCiaUYoykfJShvE3ppNCZoZUdWwJY2uk9a1yVoyMaExdFrtlSR8UJ4xvGO6ephpdZdeHXpdreOIIWJt905DWsnKFgZMLP7OnnLlaCCW03TIl9OCmrOBWz15mIfs79QYPxFymba2nRu8PlfbP3xj24F+BeErgocKq2gmaoa8C8vRkZ/GK7I2yPzz7ZI3e21/LV0saWEGHqAnigMoeA5IH5nq/VibH4nAZGS/jyhAYogZ37X+QZPPq5opS8HYnaWKFKAJtg1ISkc6beZS910ehOp6+dZXwwwjWBqsGxxNfvAVJFbaQdOT6Yruw1Q==
X-YMail-OSG: AURpIwgVM1kJxQ_MOGoux6Fh0FzY7DDMeeLR8WVM8cddBhkTR8xmtJkIOH4VWpX
 fsP3WBGCvn9nz7fZdUcPsOiJ4E34RTIWL9E44KMYgVplmL5.GD_H9m0SzNSQgjDHvNQMZae0c_A_
 dIaot8T.KjbyfxDob1kvGdiful91w8H50rbaaJvMLqrmsSyZ9WE.n4FQViu8AwJ58hqIXA1FLN_R
 5urJfoKGnCcEZExWTbi5vslwkxenZreJh7e2Uc9TIOT8EPoCR5YBaIbQegyQ5OMPlu0_g23XDqSV
 cVH6NXCFFYMLvn.cxdaCwv4TyJki17rhJIH0o4pABVfedA.Bkd9wwy3x8yLAx4pHtSx9PghJAHW9
 yUCjipT0hI2f14ZihtIDOa.ypInxYCWMXUahPwyNs7ld_fdpGq3CvAlaE_JtqVr_.s86zt8V8W_v
 UXXod7J3_0N1h6rLJ00RKkTHYh76j_P49n94efJB0OJPYlR_uBMwc6USRWJDgZ6t_f5ds7bZ9R7T
 1o_p3XNfHsmL6iL_.aYdCdkHSNJHXHVdLU7.tZN4zR2FaEMeIlb8a5EO2TONUnpywuJQrnCpoP0P
 hwsMJ20AByfqCMAmmxYbjEDm_45.2s2u4WuZdUdlxcqv2mxWvEUCR2qG67JQQl4TMuGtmTFMwDNL
 bK9O_qJQVHNCnP00qREITnYlVAESsqozD5h4zB9pQAgerclWiTM2Fe.c4mgggi2uGCApVsSDxGFL
 goqJtiQSvZABkP4TdrWJBlSYI.EnX_5xSCVXcfpQxSoLlgWv56BmYeu8Jhdtu2CxQ9jVgpo5Y_J6
 OT.7YZURx.4jinMAvUQypIAwDMJGFaSt.MTtaNqmVlAt5CD07MnrUggIOvdZAKzNk519y__lPB7v
 qxtNxxZNir2zon_3fs2YLUbe7qrJ8bgy_o7h1LRc2wCxB74c3XOcJztXB_mtyzs6AmYPBdrRwrVv
 ZWBpYfHxVvy71CPGCaGaTf1jpJBmKYWlWabVWlICktiANQdBOz_T3LcSOirPVXYpZnfFqHdtqBk1
 IOZ87jO_ROHw5IKJr5.pDVkLBAWVv_wWMTiEpsPi3.pDVYRakZwSUC9_yVLtbW_vGzwg1eDc0h3n
 uL_HtS2gm0UPhmyYtV030n6owOB_7XyW9m6cJx4VufgLk9E1E6GUeozFZTUgWP5NPwCUQljvmpEy
 .pbkT37ux5j92YqgTPWd0K9Zz3pfx4kBm41dJtSbj9.OgJXURaVWtjeNTeUQ5amwZCa0wnF5uxiy
 NeUf7VhU6oXSgk8xh8oRZIIEBNxoP0cTP4QtZUqS_doFPW7x.kwFWCBhqoEaDh.Zo_BQmYa_fZsn
 GR4OE1.V0lIaJot9MM_EhRRzfQyWNLA7.m3vV5SqUaWqIxcn7hYwDk03PHQ1Wslj8sri.VvzfcVu
 bNq_2ec8Vtnq9C4SU3tsO_nYGo9IjhJmI5RdbTmIkSu3.MtmSE5b5jJCOS.qlWhgsk23FzC08jUG
 6foDQDxrEwpPxmFHFmR7NmU3lKOY0UkuQ3RRhooYkx7YJEH2HmCloIwBtOR6Sp6JJztdJUVWgfkb
 RkVFy35dPU3cDK9c64R0d_fIzmeUXX9IT0y5XaoyCjgKXpFFDmhaXej2AhPi1pBAJPIQgit0VIKK
 YXQGs6OQ9vek9yxfMeVURJgairFnGkGFO_IphEaudhGjYRpFLatRDddIfBJNqdsEf7GUJq6wGMS9
 M4fYeVJy.CP_JNckwvDi2.E3wt0OkhFphCvMSpZYNkZuSLq7ekRtFc2Cjz1S4guiyR_4iKtY3yzF
 G5xPaYs9xPrtPSFCLiw_Qa5A9cdLLJ_PjHnnVZJ_DRnhPeNZr9JPzRpYkRVa.BNmvkLwlJNl3018
 .DLxQ2GCIDSG53yeXqQFvNJjzviX.HSohuvcj3lPug8gFbXz.h8rTrva6d3vYYThZenGwY5MviaC
 w.Bql92wGFIaA7rBPjwMTZAj5_Cmb.ieDw7IznFTp4kb9SfVaEAHKhEd8WNOYuZVz8alxurcsyJK
 ytg7bgc_sFHkUaxtZ1MGWvQxcRYm7bkJqMSE7Ijhf3giPcwL6L9pMPEYIx2rdlOwM6WRf.PPzikc
 zdlrvP7LIlx5i1BvPn3deDEWR6JUJJYfAuLrsPWdz4hBy3njUSGndMhxuAMrAWdChDa_D6.ZJFem
 2j1Mplof.9MqppM9JMljUwCa0BqKfneqsQ5PXV4U1wmYssA5Q60L_vdZtsiaT35MOOT2I5Mz8qay
 T3or4YpVEjI3Uz6QicT6g8kVDXpyVdRbpvV13mF_3.PUgfGxN6443t0tpeaSWJeSUStWv6RLbOE5
 fGmiVZqF18bRXXY7o1TnJDRyxs9zQ_nWNIuL.F0BFzK4_Tp3766ycykzZKU4aPOG2T4zsKvbnqFP
 fGyFZfu5hBNdMfNvoYgJw_ETmHWgs5gTxjLbEKNcvScf009r01DwqSXRXaDIcqejzsPVVuaYr9GX
 mLgrklWmoQ5LVqws4baXYdUfz6PSP4wfP822FJkDBTIz0hVYYZ8.CLMJq34ToNkwqGD3RAiT5y_j
 9oQEMW16f2MdtYcKe_5qqL39u2WbcFFRHpjirrl08ynDlbR9VJE8KBib9PZ0CR4kvb0F_YYcrwM_
 KpaUtxWJ7zhR7hlwkeyHIFYVO7d1AG8oaHqqABYMstA8nJk5vi3s6jZC60JwJT0e9bbXrz6CMk8g
 1fSY9omjg4EK_Av7i0oq9hpOnLC1b7PZbOTMpQf3bXRwb437CdOEo84yfN2ssD.Vjn903zwjuD3Y
 rL1xxY37th2oSUd384SKscpKh2Dla0Lg4dtLX_vuBWFI0JDjd_GDpw9V3llufCjEs65Jzz8C8ExT
 LU8xx9CZ.iRm5mmU34rdVWzqZ0O_XReY5.JgKHKklB2kMAv0Xltogx2JdJ0aTdkUsLAIzcO.sEyP
 UEEOWcxSL1tLMERq5q0j10zI8OsTEM6JJnuv8UEAVt_kzXT4fKoX.gGj0xRQz7Q3NgYxXjiL6NZS
 u1kEcaDoggaGrrZ5KAAAXUc.5wTrAA3vG.GVlvfW6EmBsvAY_EtuJKtWyiRZkzipBNeUaz6qhxHu
 M.ryh2eHOSILbcGEMIN3Mucdqxk_Aurjge7OdNUFr1tU1ubTBM0lsgSbV.vd0FQRe3vYhiCKwSLM
 IVHCx9Wp_TNCRYPo62g2l7F5NF6TOO6.ofXGerg3bM8NfOGgOQRX7B7Mz2eKGMC.mqIa0nBMW8Z6
 EFz0mveG5yXvI7T1nvyr5RZ6zX9bzo5qio0JQvP0ZI8sg190.ZIW3GupFcHQdmQ_G6Urg2j5XltW
 BpARvllNqoGPlNphuIcjYNCKG_SOtdnl9.aU5VtomQqv9VdPZwGzgbfV_Zjle1l9m80qWPoeIoox
 c0tl4Dl3cAnIIPr0Dq7r26VMba4FtJ_4pPaX5SbELPYEnHjAIkJw9YOJyKlGzSFiaPDPvSwdhVbD
 I_nTRB__Rtdvz00508ZaywwS2vmbl_bukq_.TlURR.aL3jbUb2BA4da4EdyllodF_g.E3envncj_
 U6duB07dHMIlineCVCqXMLPUe0GhLc5AaArE8ttWp9RtS.NV8W7kvvGEac97CRhweOQO3DSa9uGI
 9B_H07eiaKKSmW_wUxtSlLRSMoXRhcAl_.a3xkWFl9jDvBQS7.igw.qRxfPTJ3KUr2H9xR2CAWeX
 Y1nevU50gyQttU3jjFRP1LAzRVXnjssIULA5l20_Y9GdGnZ5FkLvMp7cm7_0IDJmfai.7LSTLCLg
 3RsfRUYyM.plL9.rSo7cS9iNIge0JpHqQQ2tP7fyKehXzHJfhM6OgHl30VPDZBPW3jokAjwHgfTc
 GcUcqqEAxJXq8os6JeMfidOPKeiKvHEEuM6JJLflbXMh56GQQ8gAqaTAOLTpV1ldObk6vEbxM2s_
 XRddtx4MsakWBV0H4XvSUI_7cs8Hh0k3GUGALGIXgvK_ynGeBkl877iBDJWozKja8v1YGJlTCgZl
 GW6OIdyHU3GKGPduJnQo3WNr107i5tKAomRM9GtNQXWzE8RUHhB4wwH2WjR915F637kbaKv9lZRG
 ixKSz0Yk3WYlQjZjf5oqR.bD.DXU7sMCNcnoykcJh2MFRPekTDDS2d64HAA7KdDGUba37f9fougR
 5iOaXlVfBA5XEVEr6EOnM0mRyJm8ZMA3bXb6rHnBOA_e7MhgHDcOspjjmmjQOhQo2jZQqCgXSYap
 KoAx9CwlGXg7UHX1uIuN3kDb8jF6IGmPHpAKUiCWvpGDMPsZVkHyIuucf4IGqR9GyYFS0rSLga49
 C8nyv86N0quq3mmo35ynksT.mBCNaaD9TKxVJd4IdbaNSRoO5nY.EP..MOV4WqTY63FW7TmAX2VD
 BBpy0tqqpC3NZyVIAi7Eo8Qo0GxxejjnPCrxuWGMee6WraQPB1h.Y9BQe9JYlcjbP6fuaYE_BeAy
 Vj1lIuBggozQ37O9HmY1HEXWkXRHGxgL_1nD6P6n41yA1MuuJR6j7g.tW63EgK2Usj7uQioWYVQF
 KZ4K0QRj7C_rKbwsU5KsNAl_fFOfs54NgcK7aWB3LOClkpESIQlSIEsuETmNgatkVbkIPNKq6cGW
 00vqJwl9_U2Jp.EakHUgTxciw9D_Oie6gxAF8J5Gvdv2qWt9EcZLiFn4aJ1Qrj.LiO27HlB2Wdqz
 4R7.Qu0SFFo5F1XR27V5VkIfQa5OJoc02vWIWvUxt54yQq27nQ79ch91bXZp4LdxR0.EMMmydgxL
 KCeof5SBiXz_UrF7HWr9U_iGUN.QG8xkKlzqjR6qfqzORZUetclQ27FVFGkx6R2zoVEc9iFr1Zq0
 tzaXGjLJbeeS3RScsoq70yeHlYjvfE1gC2Sc2HyN7IW9PXaJknSXS7cQjRMs4Pw.Z.FZw07Jh7AT
 6LERHS8wu_ICkysUN9.MnACOk3ldvoc2erhUGyAaSHDxFmcoTbggBDobZkwWxdCsZVOoNj1FDnUZ
 dMt6Lux90NSVa0MoTPdAk1g0pZrl4b.J62wNDKfbqmfjzwotYjT8OFMGrsDJsjh8niBDSCAOqIl8
 1sAN9I7KvaQyP0QPGXxQTwk37ag1_S8o96MOokaLayF8hg8JO2rHYGuAdH_b_Hyc3G3x858Io8uj
 l6qg4V9TCECs327d3PYi7UsDA8N2gux4REdwdBTuPNqBt87fsZ0VT2CwAeEvZ8bq7FaEKS9wyPyV
 QygMoirDyt5gzxyx9YLlnS9EYo6dnM8HqJWOinKc9c_cip0RQCNw3kTizdL2hMVX0HyEX1Zf8skx
 inm99fSuAOA1FGnag5JeBDQ_76YC_ftAXCagLmd9qJFnUqng88MxbxOkaDsKf.nEKH4xmr1HulV4
 fpxbqCKttJyDg8hxuH40zW5q6AHjtwpXP3kVEF0nZiSEA68WamYhtMMyuYVxQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Oct 2020 06:49:59 +0000
Date:   Fri, 23 Oct 2020 06:49:56 +0000 (UTC)
From:   CUSTOMER CENTER <customercenter739@gmail.com>
Reply-To: customercenter739@gmail.com
Message-ID: <303930332.443431.1603435796324@mail.yahoo.com>
Subject: Greetings to you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <303930332.443431.1603435796324.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Greetings to you
We are writing this letter to you from LinkedIn Company we know that
this message may come to you as a surprise you have
been selected as our new-branch manager in your country; for more
about the position reply us via this E-mail:
(info.customer01@consultant.com)The position cannot stop your business
or the work you are doing already.
Regards.Mr.Jeff.
Whatsapp +16205060599
