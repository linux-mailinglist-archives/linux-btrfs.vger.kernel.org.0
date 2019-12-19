Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CEA125C20
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 08:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSHkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 02:40:45 -0500
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:43168
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbfLSHkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 02:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576741243; bh=Z4c76Hc2ccTsbgccR1n7PWlwfYqwO2aW9NOZLFmuJSk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=HGtDCXBWHNV7kB5+kNxCbzj4qzVyIWhqct8FK3zFoAe4fnt75ErsJex21xTyP+AmpAcW6zeonhnhla+hJAcbRxL2JtYvViUmFr9mYI4gY+Pu2KDMRtbm10yCO6rScTcygYVXVBiJfamUmFv1qvfFyx74HF3+pMUBB6eoalW1A9oN6UxvWh+W63zIz9G9ZA47uk+k1Iy7L4pewT+vCuHxNfiUXnrCO3+n56vS4Q/vR2f/M70XtaP3rnAE4mx1e91q+neBLQH5MjSHvxH2f7cW2A8+dIlIE+PaTTvI8pf3JewFptw8kfsGJPvEpDPB5h/j9G0lGIO1qcwD2e5faeo79w==
X-YMail-OSG: ijKO1FYVM1lWYAVn.Ae93VQ_Gg0EOo0UE_YEG0BmwK2q7S2LEms.IkmUasnu1bn
 uPLjZKT80eLV1_4BQ7yge5_Q0BYpN1iyU4WcD_lrMrTWdq72W3UtE5InbKfCkyy5YWqK789Ib7Ei
 JWWwVAuoIifigUyf8nqGzlwFoCdABN.3BmQNjaXGMvK1V0HzWiRKaiXCOuc65eogqBbzuYGGddS3
 sV_M_Oimxy4DXTqsSb3G4u7bcm7ebI67cNvwffZvd88Cr6A37YP9D9_c_veUgAHIAK194Q75bb.G
 jDUQ2.5UzLHcKbG24W.BIWaNgUK1B9FqBWt6.5285Gax3NiUk0oIlroCId.657Ux9FtVqqOQf.nY
 XtmCahO2yqe1081OOQcbnGdbzYpdFznNX9FimWXfMWkjVwK7ujDeJ68cxy.pjtEGlhynAOMdH0_H
 GHXYs8OnTvlhn6WKuKDl2OTrnrNHNhnkgdtCL9UZslfuzEiPqsZvzmD9GBAgsnYbrSw8Jkg3iTF5
 6PShqGhtc9xVmOWHo9QOPNOaxdKouWtLbF2WYIPISHzUt00p1_Wtka9BXSSzd2.0JxN8GReD53Wi
 u9.CbjcwVlkPf..yd3UBk_fIuw9xutk.qQYpMcS01Iav4x12Jg6C252xgqH9bP.HQFi6nig6Ymff
 T_nUehFc8fRb3_6tYJr_qkuiv5eYpj1aF67rVHSUVFBesgdCJfF8oeXYzuSO9J2yT_ErtlpMakL8
 NgX7Xeoe5CLs_Adm_OwdiJBYZPbcEP0Ydt5sBj.26_jCu4Fg0LbDadwEa9aBpk64mqSt1FXlRGKO
 GzpNaIwTuGS71rJXTuGp48_qYiL5gTIQuWlX0JKKRG4mqrzJ6OgwhdCVd7y0Mp6oqCKhZ.iegqi.
 XIRd7fNB_u3NTS7R9gvN4OYrtQnUYIX7D7zPixR8fl46xGugF_yLXHonfqFpxpcMfj954GHqx7Kh
 Syz9YvrzPlKWsHzKmuRElMTMLLz_ILXzuGfg6Hd.x8TLkAs._vUC7EnPg4QaVxYSKGyYE_JJduwH
 NWxWcx.T5mRV3TqtySnJSG5CTYASbL0bTSDbkt3GtAw9gdu86qX2MFpky1lA9eTMgbw3OSi1ghka
 HB86ppBxnIAFrRdK0Y35rDL65bRG.IJpNovamRedKP2aXryCRkWr0KNxRg6wsX0x9BH6Dn7pwjZm
 s2PkBbJDBFmzNZh5AypK.8K2gRk1VcR.9HPJnJmagMvoRNPLbmolqYZHWkiGYgd4yPduPGikpy.p
 G_pP4g4FE7XRZ8yjQSlanu7guKU93hXSYJoqduJL69lQoTN2y7iJD7LskPBu64hzkkiMZHi2bRdH
 QZ1G5R4r1jU7RhzAGISWAIWzGR7saL1yFCtE918A-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 19 Dec 2019 07:40:43 +0000
Date:   Thu, 19 Dec 2019 07:40:41 +0000 (UTC)
From:   AISHA GADDAFI <mrsaishaalqaddafi1976@gmail.com>
Reply-To: mrsaishagadafi1976@gmail.com
Message-ID: <875490494.781950.1576741241969@mail.yahoo.com>
Subject: Season Greetings; Reply for business discussion
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <875490494.781950.1576741241969.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Dear Friend,
Greetings and Nice Day.
Assalamu Alaikum
May i use this medium to open a mutual communication with you seeking your acceptance towards investing in your country under your management as my partner, My name is Aisha Gaddafi and presently living in Oman, i am a Widow and single Mother with three Children, the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi) and presently i am under political asylum protection by the Omani Government.

I have funds worth "Twenty Seven Million Five Hundred Thousand United State Dollars" -$27.500.000.00 US Dollars which i want to entrust on you for investment project in your country.If you are willing to handle this project on my behalf, kindly reply urgent to enable me provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address below:

mrzaishaalqadafi1976@gmail.com

Best Regards
Mrs Aisha Gaddafi
