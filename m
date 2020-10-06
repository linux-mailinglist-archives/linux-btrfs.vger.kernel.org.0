Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0796284C0F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJFM4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 08:56:11 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:45150
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgJFM4K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 08:56:10 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1kPmQt-0008io-Sa
        for linux-btrfs@vger.kernel.org; Tue, 06 Oct 2020 14:51:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Re: Why so much "btrfs send" data for "cp -a --reflink"?
Date:   Tue, 06 Oct 2020 14:48:21 +0200
Organization: Phoenix Foundation
Message-ID: <87a6wzplka.fsf@physik.rwth-aachen.de>
References: <87362t3y67.fsf@physik.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=sha256;   protocol="application/pkcs7-signature"
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:903oDX9ysbwvpW0zxebJlYxHINk=
X-PGP-Fingerprint: C5C8 D6E2 79D2 EFE9 8C0F  6D77 D5E3 CEFC 9F51 6B77
X-PGP-Affinity: will accept encrypted message for GPG
X-Home-Page: http://www.wikipedia.org/wiki/User:Bronger
X-Face: +wpw"|jN2Fde|7<r"A\7[g0RGE#"N'WgB|46ohZy$RfV+Y!oH=FKMC>_<EQ_IdY;pJcjJrx
 {m$r$vTG>lKBa0\7!_6<ouwhB1|a+k#?z597ims{Y+POGr7Z{,b]wj]6Z"PqUHzA2\|m(:>suIE_m!
 x)'S9ytBu8tkt'k779jbzQ4o|p+@H_DCrIdnKG]E*w
X-Binford: 6100 (more power)
X-Accept-Language: de, en
Jabber-ID: torsten.bronger@jabber.rwth-aachen.de
Mail-Copies-To: never
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hall=C3=B6chen!

Torsten Bronger writes:

> I have two subvolumes A and B.  =E2=80=9EA=E2=80=9C contains 50GB data, B=
 is empty.
> None is a snapshot of the other.  Now, I copy all data from A to B
> with "cp -a --reflink A/* B".  This copying takes less than a
> second.  So apparently, no bulk data was duplicated.  "diff -rq A B"
> is empty.  So far, so good.
>
> However, it surprises me that
>
>     btrfs send -p A B | wc -c
>
> reports 12GB.

At <https://wilson.bronger.org/btrfs-receive.dump.xz>, I have
uploaded the output of "btrfs receive --dump".  Apparently, there
are many "write".  Why doesn=E2=80=99t btrfs detect that all those extents
are present in the parent?

Regards,
Torsten.

=2D-=20
Torsten Bronger

--=-=-=
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEI8w
ggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYTAkRFMSsw
KQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYDVQQLDBZULVN5
c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFsUm9vdCBDbGFzcyAy
MB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNVBAYTAkRFMUUwQwYDVQQK
EzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMg
ZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlv
biBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMtg1/9moUHN0vqH
l4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZsFVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8F
XRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0peQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+Ba
L2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qL
NupOkSk9s1FcragMvp0049ENF4N1xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz
9AkH4wKGMUZrAcUQDBHHWekCAwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU
k+PYMiba1fFKpZFK4OpL4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYD
VR0TAQH/BAgwBgEB/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGC
LB4wCAYGZ4EMAQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUv
cmwvVGVsZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYB
BQUHMAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5jZXIw
DQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4eTizDnS6
dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/MOaZ/SLick0+
hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3SPXez7vTXTf/D6OWS
T1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc22CzeIs2LgtjZeOJVEqM7
h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bPZYoaorVyGTkwggWsMIIElKAD
AgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYDVQQGEwJERTFFMEMGA1UEChM8VmVy
ZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYu
MRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRERk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcNMzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUx
RTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5n
c25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9i
YWwgSXNzdWluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp
1xCeOdfZojDbchwFfylfS2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6W
LkDh0YNMZj0cZGnlm6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mI
TQ5HjUhfZZkQ0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUk
P7agCwf9TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22M
ZD08WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAdBgNV
HQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK4OpL4qIM
z+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9v
dC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYBBQUHAQEEgdAwgc0wMwYI
KwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBKBggrBgEF
BQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/
DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCN
T1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7Ln8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+
lgQCXISoKTlslPwQkgZ7nu7YRrQbtQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v
9NsH1VuEGMGpuEvObJAaguS5Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7
EUkp2KgtdRXYShjqFu9VNCIaE40GMIIFxTCCBK2gAwIBAgIMITwlCcbKdKftcTO4MA0GCSqGSIb3
DQEBCwUAMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTE5MDcwMzEzMDI1NVoXDTIy
MDcwMjEzMDI1NVowWTELMAkGA1UEBhMCREUxFDASBgNVBAoMC1JXVEggQWFjaGVuMRowGAYDVQQL
DBFGYWNoZ3J1cHBlIFBoeXNpazEYMBYGA1UEAwwPVG9yc3RlbiBCcm9uZ2VyMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxIt1wvBlWL2/0G7NCH8mUFfYMKxDGvkhTDYpmB4k+6GtNT9l
2mka4RjFpNyd/e5l3/ocZ3IhmGKwAaqB6tuIuIfgYP5J1jZ5msb11uHL7Bpx7phFXC6EG0ML3zk0
qcdSibcSHVtxiaI7fl+O1y9XGc0DVXVTWn15uv2SsXNXhVHTGe6Z+wpdCssWV2pi+b4crAAp7K3t
2mUikg/uacH4R8YGoCUPVDitg3U+KUQK8PSFjBU+4FmS9fkXDdu8HeEWQevJqfPdMl4KTkPaR4iz
SoP4pagxRsGZ4CsweHt4NvrfDkFxmNuocXs1urmnCgYV9L7iZpkWdFyP6RVfiNae0wIDAQABo4IC
VjCCAlIwPgYDVR0gBDcwNTAPBg0rBgEEAYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQEMBAGDisG
AQQBga0hgiwCAQQEMAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUF
BwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUNZQD5+pPH0gqw7F8YDbUDcYUuJowHwYDVR0jBBgwFoAU
azqYi/nyU4na4K2yMh4JH+iqO3QwKAYDVR0RBCEwH4EdYnJvbmdlckBwaHlzaWsucnd0aC1hYWNo
ZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2Et
Z2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRl
L2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMG
CCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYB
BQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWds
b2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAE95rsRSu+9O
2hw2ZEmTXrVZLN52MNXJbOwdXguommCHvIuxkxaNwIUHEF3pVo5Z5UO55oZZaIcFyw2PS9XUhYkN
rh4T5Lp6Nqca0b3AfZOBcR16FD3bbUIpPdSQQwkuQCPiXEMam2QjCUfyC3oYja+bmPU2JDiKpunY
NJ6/KEp4Yi32U5YEKvkr7ixzl13IKdLoNjO79VCz0iXi9aZ82ixcEli3CXEDxWbo601OTm8abNUX
6QUomu5IDPGAPK65GimsXJbNYN2lhayrgGYKMslQd2ygVm2x5amfrxo1j9I6XvfnnVO1BtJ+e8Cm
BPZgGN3+6fE9G6c9IvEhfKUeWZoxggJgMIICXAIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNV
BAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHpl
cyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNz
dWluZyBDQQIMITwlCcbKdKftcTO4MA0GCWCGSAFlAwQCAQUAoIGTMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMTAwNjEyNDgyMVowKAYJKoZIhvcNAQkPMRswGTAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwLwYJKoZIhvcNAQkEMSIEIN6qNkiTDBgWoLIQqLZr2bEP
9CudEvebZAG9Y2cUhlOyMA0GCSqGSIb3DQEBAQUABIIBAAa1g1v2Gkz3Y6+n2WDO4hHh02dzp4DP
ZjGXC2TymblpRh/lHQsl0gX1RP5JIj2an6+49WuSHSDhEIm/LpeTY++huSAy9Ml4XB+OuN0sTo7L
y7HnaVsDpDQewTl1sO2qucbI6dNchyR0sVhIuMNEHbrohVeCZVOAgjWhd66KN7ImVvJvir6aR60m
+ekCePQLGYf5GDe+AS5K52Nv3ZX98eFAZLa84itpBkozXIvNp1lgwi2zPFtKnJ/1WS8qFFCYNdU4
+Nl5VZjMZ51KxGM/mf9hgQ8pUyGwQlnMR6Hq4trSJWLW6m2Q30nGknEQ7UJ9fhQPArLgrC2JCR00
CaeaqIsAAAAAAAA=
--=-=-=--

